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
    
    var body: some View {
        if userViewModel.isLoggedIn {
            ZStack {
                TabView {
                    Tab("Activités", systemImage: "dumbbell") {
                        ActivitysView()
                    }
                    Tab("Repas", systemImage: "carrot") {
                        MealsView()
                    }
                    Tab("Objectifs", systemImage: "trophy") {
                        Text("Work in progress")
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
            ZStack {
                AuthentificationSelectionView()
//                SplashView()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
