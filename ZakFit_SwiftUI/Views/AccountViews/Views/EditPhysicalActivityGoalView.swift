//
//  EditAccountView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 11/12/2024.
//

import SwiftUI

struct EditPhysicalActivityGoalView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var physicalActivityGoalViewModel : PhysicalActivityGoalViewModel
    @EnvironmentObject var chosenPeriodViewModel : ChosenPeriodViewModel
    @State var activityFrequency : String = ""
    @State var caloriesBurned : String = ""
    @State var sessionDuration : String = ""
    @State var progressionWanted : String = ""
    @State var dateStart : Date = Date.now
    @State var errorMessage : String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 32) {
                    ErrorMessageExView(errorMessage: $errorMessage)
                    VStack(alignment: .leading) {
                        TitleExView(imageSystem: "figure", title: "Fréquence d'activité")
                        NumberFieldExView(textFieldTitle: "Fréquence d'activité", textUnit: "", textInTextField: $activityFrequency)
                    }
                    VStack(alignment: .leading) {
                        TitleExView(imageSystem: "flame.fill", title: "Calories brulées")
                        NumberFieldExView(textFieldTitle: "Calories brulées", textUnit: "kcal", textInTextField: $caloriesBurned)
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
                let tempPhysicalActivityGoal : PhysicalActivityGoal = PhysicalActivityGoal(activityFrequency: Int(activityFrequency) ?? 0, caloriesBurned: Double(caloriesBurned) ?? 0, sessionDuration: Double(sessionDuration) ?? 0, progressionWanted: Double(progressionWanted) ?? 0, dateStart: dateStart, idChosenPeriod: chosenPeriodViewModel.selectedCategory.id!, idUser: userViewModel.user.id!)
                
                errorMessage = ""
                
                if !tempPhysicalActivityGoal.verifyDate() {
                    errorMessage = "Veuillez rentrer une date supérieur à celle d'aujourd'hui"
                }
                
                if errorMessage == "" {
                    if physicalActivityGoalViewModel.physicalActivityGoal == nil {
                        physicalActivityGoalViewModel.create(physicalActivityGoal: tempPhysicalActivityGoal)
                    } else {
                        physicalActivityGoalViewModel.update(physicalActivityGoal: tempPhysicalActivityGoal)
                    }
                    
                    dismiss()
                }
            }, label: {
                GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
            })
            .padding()
        }
        .navigationTitle(physicalActivityGoalViewModel.physicalActivityGoal == nil ? "Créer mon Objectif d'activité" : "Editer l'Objectif d'activité")
        .onAppear(perform: {
            if physicalActivityGoalViewModel.physicalActivityGoal != nil {
                activityFrequency = String(physicalActivityGoalViewModel.physicalActivityGoal!.activityFrequency)
                caloriesBurned = String(physicalActivityGoalViewModel.physicalActivityGoal!.caloriesBurned)
                sessionDuration = String(physicalActivityGoalViewModel.physicalActivityGoal!.sessionDuration)
                progressionWanted = String(physicalActivityGoalViewModel.physicalActivityGoal!.progressionWanted)
                dateStart = physicalActivityGoalViewModel.physicalActivityGoal!.dateStart
                chosenPeriodViewModel.selectedCategory = chosenPeriodViewModel.chosenPeriods.first(where: {
                    $0.id == physicalActivityGoalViewModel.physicalActivityGoal!.idChosenPeriod
                })!
            }
        })
    }
}

#Preview {
    EditAccountView()
}
