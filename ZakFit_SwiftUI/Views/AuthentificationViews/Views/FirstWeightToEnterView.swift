//
//  FirstWeightToEnterView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 11/12/2024.
//

import SwiftUI

struct FirstWeightToEnterView: View {
    @EnvironmentObject var userWeightViewModel : UserWeightViewModel
    @State var userWeight : UserWeight = UserWeight(weight: 0, date: Date.now, idUser: UUID())
    @State var weight : String = ""
    @State var errorMessage : String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                .background(.ultraThinMaterial)
                .opacity(0.6)
            ZStack {
                VStack {
                    VStack(alignment : .center) {
                        Text("Une dernière petite chose")
                            .bold()
                            .font(.title2)
                        Text("avant de pouvoir commencer")
                        Text(" ")
                        Text("Nous avons besoin de savoir votre poids actuel")
                            .multilineTextAlignment(.center)
                        Text(" ")
                    }
                    NumberFieldExView(textFieldTitle: "Poids", textUnit: "kg", textInTextField: $weight)
                    if errorMessage == "" {
                        Text(" ")
                    } else {
                        HStack {
                            Image(systemName: "exclamationmark.triangle")
                            Text(errorMessage)
                        }
                        .foregroundStyle(.red)
                    }
                    Button(action: {
                        errorMessage = ""
                        
                        if !userWeight.verifyWeight(weight: weight) {
                            errorMessage = "Poids invalide, doit être supérieur à 0"
                        }
                        
                        if errorMessage == "" {
                            userWeightViewModel.create(weight: userWeight.weight)
                        }
                    }, label: {
                        GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
                    })
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .padding(-16)
                        .shadow(radius: 10)
                )
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    FirstWeightToEnterView()
}
