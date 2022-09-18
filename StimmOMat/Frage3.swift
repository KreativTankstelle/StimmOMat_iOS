//
//  Frage3.swift
//  StimmOMat
//
//  Created by Achim Friedland
//

import SwiftUI

struct Frage3View: View {
    
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
                                     onFinished: {_ in })
                            }
#endif
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

struct Frage3View_Previews: PreviewProvider {
    static var previews: some View {
        Frage3View()
    }
}
