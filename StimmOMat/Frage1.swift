//
//  ContentView.swift
//  StimmOMat
//
//  Created by Achim Friedland on 10.09.22.
//

import SwiftUI

struct Frage1View: View {
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
         
                Spacer()

                Text("Frage 1")
                    .font(.system(size: 25))
                    .tracking(2)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20.0)

                Text("Was macht dich glücklich?")
                    .font(.system(size: 44))
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

struct Frage1View_Previews: PreviewProvider {
    static var previews: some View {
        Frage1View()
    }
}
