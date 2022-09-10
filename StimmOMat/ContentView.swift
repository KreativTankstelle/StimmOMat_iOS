//
//  ContentView.swift
//  StimmOMat
//
//  Created by Achim Friedland on 10.09.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showButton = false
    
    var body: some View {

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
                
                    Button{
                        print("Nutzungsbedingungen!")
                    } label: {
                        Text("Nutzungsbedingungen")
                            .font(.footnote)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                    }

                    Text("/")
                        .font(.footnote)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)

                    Button{
                        print("Datenschutz!")
                    } label: {
                        Text("Datenschutz")
                            .font(.footnote)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                    }
                    
                }
                .padding(.bottom, 30.0)
                    
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

            
            VStack(alignment: .center,
                   spacing:    20) {
         
                Spacer()

                Text("StimmOMat")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)

                Text("Hallo, ich bin der StimmOmat.")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)

                Text("Ich stelle dir jetzt 3 Fragen\nund im Anschluss mache ich dein Bild.")
                    .font(.title3)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)

                Text("Viel Spaß!")
                    .font(.title3)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
                    .frame(height: 30.0)
                
                if (showButton)
                {
                    Button{
                        showButton.toggle()
                        print("los gehts!")
                    } label: {
                        Text("Los geht's!")
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 22)
                            .padding(.vertical, 12.0)
                            .background(Color(red: 224/255, green: 2/255, blue: 121/255))
                            .font(.title)
                    }
                    .frame(height: 50)
                }
                else
                {
                    Spacer()
                        .frame(height: 50)
                        .background(Color.cyan)
                }
                
                Spacer()

            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

        }
        .onTapGesture() {
            print("view1 tapped!")
            showButton = true;
        }

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
