//
//  AccountView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 09/12/2024.
//

import SwiftUI

struct GoalsView: View {
    @EnvironmentObject var weightGoalViewModel : WeightGoalViewModel
    @EnvironmentObject var physicalActivityGoalViewModel : PhysicalActivityGoalViewModel
    @EnvironmentObject var caloriesGoalViewModel : CaloriesGoalViewModel
    
    let buttonWidth : CGFloat = 260
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            TitleExView(imageSystem: "flame.fill", title: "Objectif de Calories")
            if weightGoalViewModel.weightGoal != nil {
                Text("Ici")
            } else {
                NavigationLink(destination: {
                    EditWeightGoalView()
                }, label: {
                    GeneralButtonDisplayExView(textToDisplay: "Créer mon objectif" ,firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: buttonWidth, imageSystem: "plus")
                })
            }
            TitleExView(imageSystem: "flame.fill", title: "Objectif de Poids")
            if physicalActivityGoalViewModel.physicalActivityGoal != nil {
                Text("Ici")
            } else {
                NavigationLink(destination: {
                    EditPhysicalActivityGoalView()
                }, label: {
                    GeneralButtonDisplayExView(textToDisplay: "Créer mon objectif", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: buttonWidth, imageSystem: "plus")
                })
            }
            TitleExView(imageSystem: "flame.fill", title: "Objectif d'Activité")
            if caloriesGoalViewModel.caloriesGoal != nil {
                Text("Ici")
            } else {
                NavigationLink(destination: {
//                    EditCaloriesGoalView()
                }, label: {
                    GeneralButtonDisplayExView(textToDisplay: "Créer mon objectif", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: buttonWidth, imageSystem: "plus")
                })
            }
            Spacer()
        }
        .onAppear(perform: {
            weightGoalViewModel.fetch()
            physicalActivityGoalViewModel.fetch()
            caloriesGoalViewModel.fetch()
        })
    }
}

//#Preview {
//    GoalsView()
//}
