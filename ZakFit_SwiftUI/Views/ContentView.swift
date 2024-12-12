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
                        ActivitysView()
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
                    FirstWeightToEnterView()
                }
            }
            .onAppear(perform: {
                userWeightViewModel.fetch()
            })
        } else {
            AuthentificationSelectionView()
        }
        
    }
}

#Preview {
    ContentView()
}
