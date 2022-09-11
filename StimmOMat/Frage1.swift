//
//  Frage1.swift
//  StimmOMat
//
//  Created by Achim Friedland on 10.09.22.
//

import SwiftUI


struct Frage {
    var nummer: Int
    var title:  String
}

class Fragen {

    var fragen = [Frage]()
    
    init() {

        fragen.append(Frage(nummer: 1, title: "Was macht dich glücklich?"));
        fragen.append(Frage(nummer: 2, title: "Wenn du an deine Region, deinen Ort,\ndeine Stadt denkst..."));
        fragen.append(Frage(nummer: 3, title: "Wenn 3 eine Stadt denkst..."));
        fragen.append(Frage(nummer: 4, title: "eine 4 Stadt denkst..."));

    }
    
    func GetTitle(number: Int) -> String
    {
        return fragen[number-1].title
    }
    
}


struct Frage1View: View {
    
    var nummer: Int
    var fragen: Fragen = Fragen()

    @State private var capturedImage: UIImage?     = nil
    @State private var isCustomCameraViewPresented = false
    
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
         
                Text("Frage " + String(nummer))
                    .font(.system(size: 25))
                    .tracking(2)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 25.0)
                    .padding(.bottom, 30.0)

                Text(fragen.GetTitle(number: nummer))
                    .font(.system(size: 42))
                    .tracking(1)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30.0)

                Spacer()
                
                
                
                
                if capturedImage != nil {
                    Image(uiImage: capturedImage!)
                        .resizable()
                        .frame(
                            width:     (capturedImage?.size.width )!/3,
                            height:    (capturedImage?.size.height)!/3,
                            alignment: .center)
                       // .scaledToFill()
                       // .ignoresSafeArea()
                } else {
                    CustomCameraView(captureImage: $capturedImage)
                        .frame(
                            width:     UIScreen.main.bounds.width/2,
                            height:    UIScreen.main.bounds.height/2,
                            alignment: .center)
//                    Color(UIColor.systemBackground)
                }
                

                
                Button(
                    action: {
                        capturedImage = nil
                        isCustomCameraViewPresented.toggle()
                    },
                    label: {
                        Image(systemName: "camera.fill")
                            .font(.largeTitle)
                            .padding()
                            .background(Color.black)
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

                Spacer()
                
                NavigationLink(destination: Frage2View().navigationBarBackButtonHidden(true)) {
                    Text("Nächste Frage")
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 22)
                        .padding(.vertical, 12.0)
                        .background(Color(red: 224/255, green: 2/255, blue: 121/255))
                        .font(.title)
                }
                .frame(height: 50)
                
                Spacer()
                
                
                
                Text("Du hast gleich 30 Sekunden Zeit um die Frage zu beantworten.")
                    .font(.system(size: 16))
                    .foregroundColor(Color.white)
                    .padding(.trailing, 10.0)
                    .padding(.bottom,    7.0)
                    .frame(maxWidth:  .infinity,
                           alignment: .bottomTrailing)

                HStack {

                    Text("")
                      .frame(width:     150,
                             height:     25,
                             alignment: .center)
                      .background(Color.green)

                    Spacer()
                }
                .background(Color.white)
                
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

        }

    }

}

struct Frage1View_Previews: PreviewProvider {
    static var previews: some View {
        Frage1View(nummer: 1)
    }
}
