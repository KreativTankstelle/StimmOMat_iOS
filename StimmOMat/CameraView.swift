//
//  CameraView.swift
//  StimmOMat
//
//  Created by Achim Friedland on 11.09.22.
//

import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {

    typealias UIViewControllerType = UIViewController

    let cameraService: CameraService
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
        viewController.view.layer.addSublayer(cameraService.previewLayer)
        
        cameraService.previewLayer.frame = CGRect(x:      0,
                                                  y:      0,
                                                  width:  viewController.view.bounds.width/2,
                                                  height: viewController.view.bounds.height/2)

        return viewController

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, didFinishProcessingPhoto: didFinishProcessingPhoto)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
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
