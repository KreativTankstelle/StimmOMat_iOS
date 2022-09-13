//
//  CameraService.swift
//  StimmOMat
//
//  Created by Achim Friedland on 10.09.22.
//

import Foundation
import AVFoundation

class CameraService {

    var session:  AVCaptureSession?
    var delegate: AVCapturePhotoCaptureDelegate?
    var position: AVCaptureDevice.Position = AVCaptureDevice.Position.front

    init (position: AVCaptureDevice.Position)
    {
        self.position = position
    }
    
    let output       = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    func start(delegate:   AVCapturePhotoCaptureDelegate,
               completion: @escaping (Error?) -> ()) {
        
        self.delegate = delegate
        
        checkPermissions(completion: completion)
        
    }
    
    private func checkPermissions(completion: @escaping (Error?) -> ()) {
        
        let cameraPosition = self.position
        
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
                setupCamera(position:   position,
                            completion: completion)

            @unknown default:
                break

        }
    
    }
    
    private func setupCamera(position:   AVCaptureDevice.Position,
                             completion: @escaping (Error?) -> ()) {
        
        let session = AVCaptureSession()
 
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                for:      .video,
                                                position: position) {
            do
            {
                
                let input = try AVCaptureDeviceInput(device: device)
                
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if (session.canAddOutput(output)) {
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session      = session
                
                session.startRunning()
                
                self.session              = session
                
            }
            catch {
                completion(error)
            }
        }
    
    }
    
    func capturePhoto(with settings: AVCapturePhotoSettings = AVCapturePhotoSettings()) {
        
        let settings2 = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        settings2.flashMode = .on
        
        // conflicts with: maxPhotoQualityPrioritization
        // settings2.photoQualityPrioritization = .quality

        output.capturePhoto(with: settings2, delegate: delegate!)
        
    }
    
}
