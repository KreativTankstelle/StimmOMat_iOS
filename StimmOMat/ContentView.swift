//
//  ContentView.swift
//  StimmOMat
//
//  Created by Achim Friedland on 10.09.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var player     = AudioHandler();
    @State private var showButton = false

    var body: some View {
        
        NavigationView {
            
            ZStack {

                Image("mainScreen-background")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .center,
                       spacing:    0) {
             
                    Image("mainScreen-top")
                        .resizable()
                        .scaledToFit()
                        .padding(0)

                    Spacer()

                    Image("mainScreen-bottom")
                        .resizable()
                        .scaledToFit()
                        .padding(0)

                }
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

                VStack(alignment: .center,
                       spacing:    20) {
             
                    Spacer()
                    
                    HStack()
                    {

                        NavigationLink(destination: NutzungsbedingungenView()) {
                                       Text("Nutzungsbedingungen!")
                                .font(.footnote)
                                .foregroundColor(Color.white)
                                    }

                        Text("/")
                            .font(.footnote)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)

                        
                        NavigationLink(destination: DatenschutzView()) {
                                       Text("Datenschutz!")
                                .font(.footnote)
                                .foregroundColor(Color.white)
                                    }
                        
                    }
                    .padding(.bottom, 30.0)
                        
                }
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

                
                VStack(alignment: .center,
                       spacing:   0) {
             
                    Spacer()

                    Text("StimmOMat")
                        .font(.system(size: 66))
                        .fontWeight(.semibold)
                        .tracking(2)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 15.0)

                    Text("Hallo, ich bin der StimmOmat.")
                        .font(.system(size: 33))
                        .fontWeight(.semibold)
                        .tracking(2)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 30.0)

                    Text("Ich stelle dir jetzt 3 Fragen\nund im Anschluss mache ich dein Bild.")
                        .font(.system(size: 25))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 50.0)

                    Text("Viel Spaß!")
                        .font(.system(size: 25))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 50.0)

                    Spacer()
                        .frame(height: 30.0)

                  //  if (showButton)
                  //  {
                    
                    NavigationLink(destination: Frage1View().navigationBarBackButtonHidden(true)) {
                        Text("Los geht's!")
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 22)
                            .padding(.vertical, 12.0)
                            .background(Color(red: 224/255, green: 2/255, blue: 121/255))
                            .font(.title)
                    }
                    .frame(height: 50)
                    
                  //  }
                  //  else
                  //  {
                  //      Spacer()
                  //          .frame(height: 50)
                  //  }
                    
                    Spacer()

                }
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

            }
            .onTapGesture() {
                print("view1 tapped!")
                if (player.isPlaying == false) {
                    player.playAudio(filename:   "stimmomat1_2_start",
                                     onFinished: {_ in showButton = true })
                }
            }

        }
        .navigationViewStyle(StackNavigationViewStyle())

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
