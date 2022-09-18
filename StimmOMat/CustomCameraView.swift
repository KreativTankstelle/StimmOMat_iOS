//
//  CustomCameraView.swift
//  StimmOMat
//
//  Created by Achim Friedland on 11.09.22.
//

import SwiftUI
import AVFoundation

struct CustomCameraView: View {
    
    public static var previewScaling = 0.55

    let cameraService = CameraService(position: AVCaptureDevice.Position.front)

    @Binding var captureImage: UIImage?
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        
        ZStack {
            
            GeometryReader { geometry in
                CameraView(wwidth:        geometry.size.width,
                           hheight:       geometry.size.height,
                           cameraService: cameraService) { result in
                    switch result {
                        
                    case .success(let photo):
                        if let data = photo.fileDataRepresentation() {
                            captureImage = UIImage(data: data)
                        } else {
                            print("Error: no image data found!")
                        }
                        
                    case .failure(let err):
                        print(err.localizedDescription)
                        
                    }
                }
            }
            
//            .scaledToFit()

            Image("photoOverlay_2000x3000")
                .resizable(resizingMode: .stretch)
                .scaledToFit()
                .opacity(0.7)
            
            VStack {
                Spacer()
                Button(
                    action: {
                        cameraService.capturePhoto()
                    },
                    label: {
                        Image(systemName: "camera.fill")
                            .font(.largeTitle)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                )
                .padding(.bottom, 30)
            }
            
        }
        
    }
    
}
