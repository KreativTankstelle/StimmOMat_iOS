//
//  TermsOfServiceView.swift
//  StimmOMat
//
//  Created by Achim Friedland
//

import SwiftUI

struct TermsOfServiceView: View {
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
                   spacing:   0) {
         
                Spacer()

                Text("Nutzungsbedingungen")
                    .font(.system(size: 44))
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

                Spacer()
                
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

        }

    }

}

struct NutzungsbedingungenView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfServiceView()
    }
}
