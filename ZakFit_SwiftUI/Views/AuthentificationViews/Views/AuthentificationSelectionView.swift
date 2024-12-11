//
//  ConnectionView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct AuthentificationSelectionView: View {
    let buttonArray : [String] = ["Connexion", "Inscription"]
    @State var selectedButton : String = ""
    
    var body: some View {
        VStack {
            Image("ZF_fullLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 120)
            HStack {
                ForEach(buttonArray, id: \.self) { actualButton in
                    Button(action: {
                        selectedButton = actualButton
                    }, label: {
                        GeneralButtonDisplayExView(textToDisplay: actualButton,
                                                   firstColor: actualButton == selectedButton ? .zfOrange : .zfLightGray,
                                                   secondColor: .zfMediumGray,
                                                   textColor: actualButton == selectedButton ? .white : .black)
                        
                    })
                }
            }
            VStack {
                if selectedButton == "Connexion" {
                    ConnectionView()
                } else {
                    RegisterView(selectedButton: $selectedButton)
                }
            }
        }
        .onAppear(perform: {
            selectedButton = buttonArray.first ?? ""
        })
        .padding()
    }
}

#Preview {
    AuthentificationSelectionView()
}
