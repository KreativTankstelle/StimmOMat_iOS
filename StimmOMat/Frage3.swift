//
//  Frage3.swift
//  StimmOMat
//
//  Created by Achim Friedland
//

import SwiftUI

struct Frage3View: View {
    
    @State var timer = Timer.publish(every:  0.05,
                                     on:    .main,
                                     in:    .common).autoconnect()

    @State var counter: Float  = -1
    @State var message: String = "Du hast gleich 30 Sekunden Zeit um die Frage zu beantworten."
    
    @State private var player = AudioHandler();

    var body: some View {

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
                        player.playAudio(filename:   "stimmomat1_2_frage3",
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
         
                Text("Frage 3")
                    .font(.system(size: 25))
                    .tracking(2)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 35.0)
                    .padding(.bottom, 30.0)

                Text("Damit sich etwas ändert...")
                    .font(.system(size: 42))
                    .tracking(1)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 15.0)

                Text("Wofür machst du dich stark?")
                    .font(.system(size: 35))
                    .tracking(1)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)

                Text("Was könntest du tun?")
                    .font(.system(size: 35))
                    .tracking(1)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30.0)
                
                Spacer()

                HStack {

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
                .padding()
                
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

struct Frage3View_Previews: PreviewProvider {
    static var previews: some View {
        Frage3View()
    }
}
