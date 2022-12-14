//
//  CameraView.swift
//  StimmOMat
//
//  Created by Achim Friedland
//

import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {

    typealias UIViewControllerType = UIViewController

    let viewWidth:                CGFloat
    let viewHeight:               CGFloat
    let cameraService:            CameraService
    let didFinishProcessingPhoto: (Result<AVCapturePhoto, Error>) -> ()
    
    func makeUIViewController(context: Context) -> UIViewController {

        cameraService.start(delegate: context.coordinator) { err in
            if let err = err {
                didFinishProcessingPhoto(.failure(err))
                return
            }
        }

        let viewController = UIViewController()
        viewController.view.backgroundColor = .black
        
        cameraService.previewLayer.videoGravity = .resizeAspectFill
        cameraService.previewLayer.frame = CGRect(x:      0,
                                                  y:      0,
                                                  width:  viewWidth,
                                                  height: viewHeight)

   //     DispatchQueue.main.async {
            viewController.view.layer.addSublayer(cameraService.previewLayer)
   //     }
        
        return viewController

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, didFinishProcessingPhoto: didFinishProcessingPhoto)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    
    
    // https://blog.devgenius.io/camera-preview-and-a-qr-code-scanner-in-swiftui-48b111155c66
    // https://www.raywenderlich.com/11764166-getting-started-with-photokit
    // https://developer.apple.com/tutorials/sample-apps/capturingphotos-captureandsave
    class Coordinator: NSObject, AVCapturePhotoCaptureDelegate {
        
        let parent: CameraView
        private var didFinishProcessingPhoto: (Result<AVCapturePhoto, Error>) -> ()
        
        init(_
             parent: CameraView,
             didFinishProcessingPhoto: @escaping (Result<AVCapturePhoto, Error>) -> ()) {
            
            self.parent                   = parent
            self.didFinishProcessingPhoto = didFinishProcessingPhoto
                        
        }
        
        func photoOutput(_                        output: AVCapturePhotoOutput,
                         didFinishProcessingPhoto photo:  AVCapturePhoto,
                         error:                           Error?) {
            
            if let error = error {
                didFinishProcessingPhoto(.failure(error))
                return
            }
            
            didFinishProcessingPhoto(.success(photo))
            
        }
        
    }
    
}
