//
//  Frage1.swift
//  StimmOMat
//
//  Created by Achim Friedland
//

import SwiftUI
import AVFoundation


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
    
    @State var timer = Timer.publish(every:  0.05,
                                     on:    .main,
                                     in:    .common).autoconnect()

    @State var counter: Float  = -1
    @State var message: String = "Du hast gleich 30 Sekunden Zeit um die Frage zu beantworten."
    
    @State private var player = AudioHandler();
    
    @State private var capturedImage: UIImage?     = nil
  //  @State private var isCustomCameraViewPresented = false
    
   // init(nummer: Int) {
   //     self.nummer = nummer
   // }

    
    var body: some View {

//        if (self.isViewLoaded() && body.window != nil) {
//        }

        
        ZStack {

            Image("mainScreen-background")
                .resizable(resizingMode: .stretch)
                .scaledToFill()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .frame(maxWidth:  UIScreen.main.bounds.width,
                       maxHeight: UIScreen.main.bounds.height)
                .onAppear {
#if targetEnvironment(simulator)
                        print("simulator!")
#else
                    if (player.isPlaying == false) {
                        player.playAudio(filename:   "stimmomat1_2_frage1",
                                         onFinished: {_ in
                            counter = 30
                        })
                    }
#endif
                }
                .onReceive(timer) { input in
                    if (counter > -1) {
                        counter -= 0.05
                        message = counter >= 0
                                      ? String(format: "%.0f", counter) + " Sekunden"
                                      : "0 Sekunden"
                    }
                }

            VStack(alignment: .center,
                   spacing:   0) {
         
                Text("Frage " + String(nummer))
                    .font(.system(size: 25))
                    .tracking(2)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 35.0)
                    .padding(.bottom, 30.0)

                Text(fragen.GetTitle(number: nummer))
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
                            .frame(
                                width:     (capturedImage?.size.width )!/3,
                                height:    (capturedImage?.size.height)!/3,
                                alignment: .center)
                            .padding(12.0)
                            .border(.white, width: 12)
                           // .scaledToFill()
                           // .ignoresSafeArea()
                        
                            
                        Button(
                            action: {
                                capturedImage = nil
                             //   isCustomCameraViewPresented.toggle()
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

                    }
                    
                } else {
                    CustomCameraView(showOverlay:  false,
                                     captureImage: $capturedImage)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(12.0)
                        .border(.white, width: 12)
                }

                Spacer()
                
                HStack {
                    
                    NavigationLink(destination: Frage2View().navigationBarBackButtonHidden(true)) {
                        Text("Nächste Frage")
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 22)
                            .padding(.vertical, 12.0)
                            .background(Color(red: 224/255, green: 2/255, blue: 121/255))
                            .font(.title)
                    }
                    .padding()
                    
                    
                    
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
                    .padding()

                }
//                .padding()

                Spacer()
                
                Text(message)
                    .font(.system(size: 16))
                    .foregroundColor(Color.white)
                    .padding(.trailing, 10.0)
                    .padding(.bottom,    7.0)
                    .frame(maxWidth:  .infinity,
                           alignment: .bottomTrailing)

                HStack(spacing: 0) {

                    Text("")
                      .frame(width: counter >= 0
                             ? abs( CGFloat(UIScreen.main.bounds.width) / 30.0 * CGFloat(counter))
                             : UIScreen.main.bounds.width,
                             height:     25,
                             alignment: .center)
                      .background(Color.green)

                    Text("")
                      .frame(width: counter >= 0
                             ? abs( CGFloat(UIScreen.main.bounds.width) / 30.0 * CGFloat(30-counter))
                             : 0,
                             height:     25,
                             alignment: .center)
                      .background(Color.white)
                    
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
