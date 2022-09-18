//
//  TakePhoto.swift
//  StimmOMat
//
//  Created by Achim Friedland on 17.09.2022.
//

import SwiftUI
import AVFoundation

public extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
        
    }
}

struct NavigationUtil {
  static func popToRootView() {
            
      findNavigationController(viewController:
      UIApplication
      .shared
      .connectedScenes
      .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
      .first   { $0.isKeyWindow }?.rootViewController)?
            
      .popToRootViewController(animated: true)
      
  }

  static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
      
    guard let viewController = viewController else {
      return nil
    }

    if let navigationController = viewController as? UINavigationController {
      return navigationController
    }

    for childViewController in viewController.children {
      return findNavigationController(viewController: childViewController)
    }

    return nil
      
  }
}

struct TakePhotoView: View {
    
    @State private var capturedImage: UIImage?     = nil
    @State private var isCustomCameraViewPresented = false
    
    @State private var usageOK   = false
    @State private var privacyOK = false
    
    private var textSize = 23

    var body: some View {

        ZStack {

            Image("mainScreen-background")
                .resizable(resizingMode: .stretch)
                .scaledToFill()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .frame(maxWidth:  UIScreen.main.bounds.width,
                       maxHeight: UIScreen.main.bounds.height)
            
            VStack(alignment: .center,
                   spacing:   0) {
         
                Text("Foto")
                    .font(.system(size: 25))
                    .tracking(2)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 35.0)
                    .padding(.bottom, 30.0)

                Text("Alles so in Ordnung?")
                    .font(.system(size: 42))
                    .tracking(1)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30.0)

                Spacer()
                
                
                
                
                if capturedImage != nil {
                    ZStack {
                        
                        Image(uiImage: capturedImage!)
                            .resizable()
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                            .border(.white, width: 12)
                            .scaledToFit()
                           // .ignoresSafeArea()

                        Button(
                            action: {
                                capturedImage = nil
                                isCustomCameraViewPresented.toggle()
                            },
                            label: {
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(size: 50))
                                    .padding()
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            })
                            .padding(.top, 10)
                            //.sheet(
                            //    isPresented: $isCustomCameraViewPresented,
                            //    content: {
                            //        CustomCameraView(captureImage: $capturedImage)
                            //    }
                            //)

                    }
                    
                } else {
                        
                    CustomCameraView(captureImage: $capturedImage)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(12.0)
                        .border(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0), width: 12)
                }


                Spacer()

                
                VStack {


                    HStack {
                        
                        Toggle(isOn:  $usageOK,
                               label: {})
                            .labelsHidden()

                        Text("Ich bin mit den")
                            .foregroundColor(Color.white)
                            .font(.system(size: CGFloat(textSize)))
                        
                        NavigationLink(destination: NutzungsbedingungenView()) {
                            Text("Nutzungsbedingungen")
                                .foregroundColor(Color.yellow)
                                .font(.system(size: CGFloat(textSize)))
                        }
                        
                        Text("einverstanden")
                            .foregroundColor(Color.white)
                            .font(.system(size: CGFloat(textSize)))
                        
                    }
                    .frame(maxWidth:  650,
                           alignment: .leading)



                    HStack {

                        Toggle(isOn:  $privacyOK,
                               label: {})
                            .labelsHidden()

                        Text("Ich bin mit den")
                            .foregroundColor(Color.white)
                            .font(.system(size: CGFloat(textSize)))
                        
                        NavigationLink(destination: DatenschutzView()) {
                            Text("Datenschutzbestimmungen")
                                .foregroundColor(Color.yellow)
                                .font(.system(size: CGFloat(textSize)))
                        }
                        
                        Text("einverstanden")
                            .foregroundColor(Color.white)
                            .font(.system(size: CGFloat(textSize)))
                    }
                    .frame(maxWidth:  650,
                           alignment: .leading)


                    
                }
                .padding(.trailing, 50.0)
                .padding(.top,      40.0)
                .padding(.bottom,   30.0)

                Spacer()

                HStack {
                    
                    Button(action: {}) {
                        Text("Drucken")
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 22)
                            .padding(.vertical, 12.0)
                            .background(Color(red: 224/255, green: 2/255, blue: 121/255))
                            .font(.title)
                    }
                    
                    Button(action: {
                        NavigationUtil.popToRootView()
                    }) {
                        Text("Neustart")
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 22)
                            .padding(.vertical, 12.0)
                            .background(Color(red: 224/255, green: 2/255, blue: 121/255))
                            .font(.title)
                    }

                }
                .padding(.bottom,   50.0)

                Spacer()

                
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

        }

    }

}

struct TakePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        TakePhotoView()
    }
}
