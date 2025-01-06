//
//  AuthentificationSelectionView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 20/12/2024.
//


import SwiftUI

struct AccountSelectionView: View {
    let buttonArray : [String] = ["Compte", "Objectifs"]
    @State var selectedButton : String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    ForEach(buttonArray, id: \.self) { actualButton in
                        Button(action: {
                            selectedButton = actualButton
                        }, label: {
                            GeneralButtonDisplayExView(textToDisplay: actualButton, firstColor: actualButton == selectedButton ? .zfOrange : .zfLightGray, secondColor: .zfMediumGray, textColor: actualButton == selectedButton ? .white : .black)
                        })
                    }
                }
                VStack {
                    if selectedButton == "Compte" {
                        AccountView()
                    } else {
                        GoalsView()
                    }
                }
            }
            .onAppear(perform: {
                selectedButton = buttonArray.first ?? ""
            })
            .padding()
        }
    }
}
