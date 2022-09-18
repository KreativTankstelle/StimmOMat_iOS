//
//  Frage2.swift
//  StimmOMat
//
//  Created by Achim Friedland
//

import SwiftUI

struct Frage2View: View {
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
         
                Text("Frage 2")
                    .font(.system(size: 25))
                    .tracking(2)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 35.0)
                    .padding(.bottom, 30.0)

                Text("Wenn du an deine Region, deinen Ort,\ndeine Stadt denkst...")
                    .font(.system(size: 42))
                    .tracking(1)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5.0)

                Text("Was muss sich ändern?")
                    .font(.system(size: 42))
                    .tracking(1)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30.0)

                
                Spacer()
                
                NavigationLink(destination: Frage3View().navigationBarBackButtonHidden(true)) {
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

struct Frage2View_Previews: PreviewProvider {
    static var previews: some View {
        Frage2View()
    }
}
