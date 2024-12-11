//
//  ZakFit_SwiftUIApp.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import SwiftUI

@main
struct ZakFit_SwiftUIApp: App {
    @StateObject var userViewModel = UserViewModel()
    @StateObject var userWeightViewModel = UserWeightViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    userViewModel.verifyIfLoggedIn()
                })
        }
        .environmentObject(userViewModel)
        .environmentObject(userWeightViewModel)
    }
}
