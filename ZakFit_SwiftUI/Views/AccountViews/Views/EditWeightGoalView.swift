//
//  EditAccountView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 11/12/2024.
//

import SwiftUI

struct EditWeightGoalView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var weightGoalViewModel : WeightGoalViewModel
    @EnvironmentObject var chosenPeriodViewModel : ChosenPeriodViewModel
    @State var weight : String = ""
    @State var dateStart : Date = Date.now
    @State var errorMessage : String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 32) {
                    ErrorMessageExView(errorMessage: $errorMessage)
                    VStack(alignment: .leading) {
                        TitleExView(imageSystem: "figure", title: "Poids")
                        LittleTextExView(textToDisplay: "Rentrer un poids négatifs si vous voulez perdre du poids")
                        NumberFieldExView(textFieldTitle: "Poids", textUnit: "kg", textInTextField: $weight)
                    }
                    VStack(alignment: .leading) {
                        TitleExView(imageSystem: "calendar", title: "Date de début de l'objectif")
                        DatePickerExView(datePickerTitle: "", date: $dateStart)
                    }
                    VStack(alignment: .leading) {
                        TitleExView(imageSystem: "clock", title: "Durée de l'objectif")
                        ChosenPeriodPickerExView(pickerTitle: "")
                    }
                    ErrorMessageExView(errorMessage: $errorMessage)
                }
                .padding()
            }
            Button(action: {
                let tempWeightGoal : WeightGoal = WeightGoal(weight: Double(weight) ?? 0, dateStart: dateStart, idChosenPeriod: chosenPeriodViewModel.selectedCategory.id!, idUser: userViewModel.user.id!)
                
                errorMessage = ""
                
                if !tempWeightGoal.verifyDate() {
                    errorMessage = "Veuillez rentrer une date supérieur à celle d'aujourd'hui"
                }
                
                if errorMessage == "" {
                    if weightGoalViewModel.weightGoal == nil {
                        weightGoalViewModel.create(weightGoal: tempWeightGoal)
                    } else {
                        weightGoalViewModel.update(weightGoal: tempWeightGoal)
                    }
                    
                    dismiss()
                }
            }, label: {
                GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
            })
            .padding()
        }
        .navigationTitle(weightGoalViewModel.weightGoal == nil ? "Créer mon Objectif de poids" : "Editer l'Objectif de poids")
        .onAppear(perform: {
            if weightGoalViewModel.weightGoal != nil {
                weight = String(weightGoalViewModel.weightGoal!.weight)
                dateStart = weightGoalViewModel.weightGoal!.dateStart
                chosenPeriodViewModel.selectedCategory = chosenPeriodViewModel.chosenPeriods.first(where: {
                    $0.id == weightGoalViewModel.weightGoal!.idChosenPeriod
                })!
            }
        })
    }
}

#Preview {
    EditAccountView()
}
