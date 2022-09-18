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
                CameraView(viewWidth:     geometry.size.width,
                           viewHeight:    geometry.size.height,
                           cameraService: cameraService) { result in
                    switch result {
                        
                    case .success(let photo):
                        if let data = photo.fileDataRepresentation() {
                            captureImage = cropToPreviewLayer(originalImage: UIImage(data: data)!)
                        } else {
                            print("Error: no image data found!")
                        }
                        
                    case .failure(let err):
                        print(err.localizedDescription)
                        
                    }
                }
            }

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
    
    func cropToPreviewLayer(originalImage: UIImage) -> UIImage? {
        guard let cgImage = originalImage.cgImage else { return nil }

        let outputRect = cameraService.previewLayer.metadataOutputRectConverted(fromLayerRect: cameraService.previewLayer.bounds)
        let width      = CGFloat(cgImage.width)
        let height     = CGFloat(cgImage.height)
        let cropRect   = CGRect(x:      outputRect.origin.x    * width,
                                y:      outputRect.origin.y    * height,
                                width:  outputRect.size.width  * width,
                                height: outputRect.size.height * height)

        if let croppedCGImage = cgImage.cropping(to: cropRect) {

            let photo    = UIImage(cgImage:     croppedCGImage,
                                   scale:       1.0,
                                   orientation: .leftMirrored) //originalImage.imageOrientation)

            let overlay  = UIImage(named: "photoOverlay_2000x3000")

            let size     = CGSize(width:  photo.size.width,
                                  height: photo.size.height)

            UIGraphicsBeginImageContext(size)

            let areaSize = CGRect(x:      0,
                                  y:      0,
                                  width:  size.width,
                                  height: size.height)

            photo.draw(in: areaSize)

            overlay!.draw(in: areaSize, blendMode: .normal, alpha: 0.8)

            let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!

            UIGraphicsEndImageContext()
            
            return newImage
            
        }

        return nil
        
    }
    
}
