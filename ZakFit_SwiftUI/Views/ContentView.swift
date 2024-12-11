//
//  ContentView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var userWeightViewModel : UserWeightViewModel
    @State var userWeight : UserWeight = UserWeight(weight: 0, date: Date.now, idUser: UUID())
    @State var weight : String = ""
    @State var errorMessage : String = ""
    
    var body: some View {
        if userViewModel.isLoggedIn {
            ZStack {
                TabView {
                    Tab("Activités", systemImage: "dumbbell") {
                        AccountView()
                    }
                    Tab("Repas", systemImage: "carrot") {
                        AccountView()
                    }
                    Tab("Objectifs", systemImage: "trophy") {
                        AccountView()
                    }
                    Tab("Compte", systemImage: "person") {
                        AccountView()
                    }
                }
                if userWeightViewModel.userWeights == [] {
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .ignoresSafeArea()
                            .background(.ultraThinMaterial)
                            .opacity(0.6)
                        ZStack {
                            VStack {
                                Text("Une dernière petite chose avant de pouvoir commencer.")
                                Text("Nous avons besoin de savoir votre poids actuel")
                                NumberFieldExView(textFieldTitle: "Poids", textUnit: "kg", textInTextField: $weight)
                                Button(action: {
                                    errorMessage = ""
                                    
                                    if !userWeight.verifyWeight(weight: weight) {
                                        errorMessage = "Poids invalide, doit être supérieur à 0"
                                        print(errorMessage)
                                    }
                                    
                                    if errorMessage == "" {
                                        print("Poids valide")
                                        userWeightViewModel.createUserWeight(weight: userWeight.weight)
                                    }
                                }, label: {
                                    GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
                                })
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.red)
                                    .padding(-16)
                            )
                            .padding()
                        }
                        .padding()
                    }
                }
            }
            .onAppear(perform: {
                userWeightViewModel.fetchUserWeights()
            })
        } else {
            AuthentificationSelectionView()
        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(UserViewModel())
}
