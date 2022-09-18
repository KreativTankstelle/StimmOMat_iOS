//
//  CameraService.swift
//  StimmOMat
//
//  Created by Achim Friedland
//

import Foundation
import AVFoundation

class CameraService {

    var captureSession:  AVCaptureSession?
    var captureDelegate: AVCapturePhotoCaptureDelegate?
    var cameraPosition:  AVCaptureDevice.Position = AVCaptureDevice.Position.front

    init (position: AVCaptureDevice.Position)
    {
        self.cameraPosition = position
    }
    
    let output       = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    func start(delegate:   AVCapturePhotoCaptureDelegate,
               completion: @escaping (Error?) -> ()) {
        
        self.captureDelegate = delegate
        
        checkPermissions(completion: completion)
        
    }
    
    private func checkPermissions(completion: @escaping (Error?) -> ()) {
        
        let cameraPosition = self.cameraPosition
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
 
                    guard granted else { return }
                    
                    DispatchQueue.main.async {
                        self?.setupCamera(position:   cameraPosition,
                                          completion: completion)
                    }

                }

            case .restricted:
                break
            
            case .denied:
                break
            
            case .authorized:
                setupCamera(position:   cameraPosition,
                            completion: completion)

            @unknown default:
                break

        }
    
    }
    
    private func setupCamera(position:   AVCaptureDevice.Position,
                             completion: @escaping (Error?) -> ()) {
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo

        if let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                       for:      .video,
                                                       position: position) {
            do
            {

                let input = try AVCaptureDeviceInput(device: captureDevice)

                try captureDevice.lockForConfiguration()
                
                input.device.videoZoomFactor = input.device.maxAvailableVideoZoomFactor

                if (input.device.isLowLightBoostSupported) {
              //      input.device.automaticallyEnablesLowLightBoostWhenAvailable = true
                }

               // input.device.isFaceDrivenAutoExposureEnabled = true
               // input.device.isFaceDrivenAutoFocusEnabled = true
                
                captureDevice.unlockForConfiguration()

                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                }
                
                if (captureSession.canAddOutput(output)) {
                    output.isHighResolutionCaptureEnabled = true
                    output.maxPhotoQualityPrioritization  = .quality
                    captureSession.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session      = captureSession
                
                captureSession.startRunning()
                
                self.captureSession       = captureSession
                
            }
            catch {
                completion(error)
            }
        }
        
        captureSession.commitConfiguration()
    
    }
    
    func capturePhoto(with settings: AVCapturePhotoSettings = AVCapturePhotoSettings()) {
        
        let photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        photoSettings.flashMode                     = .on
        photoSettings.photoQualityPrioritization    = .quality
        photoSettings.isHighResolutionPhotoEnabled  = true
        
//        photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])

        output.capturePhoto(with:     photoSettings,
                            delegate: captureDelegate!)
        
    }
    
}
