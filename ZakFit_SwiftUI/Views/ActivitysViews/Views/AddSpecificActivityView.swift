//
//  AddActivityView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 12/12/2024.
//

import SwiftUI

struct AddSpecificActivityView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var intensityViewModel : IntensityViewModel
    @EnvironmentObject var physicalActivityViewModel : PhysicalActivityViewModel
    var activityType : ActivityType
    @State var date : Date = Date.now
    @State var duration : String = ""
    @State var caloriesBurned : String = ""
    @State var errorMessage : String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text(activityType.name)
                .bold()
                .font(.title)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.zfOrange)
                            .offset(y : 4)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                    }
                        .padding(-8)
                )
                .padding()
            VStack(alignment: .leading) {
                TitleExView(imageSystem: "calendar", title: "Date de l'activité")
                DatePickerExView(datePickerTitle: "", date: $date)
                TitleExView(title: "Durée de l'activité")
                NumberFieldExView(textFieldTitle: "Durée de l'activité", textUnit: "h", textInTextField: $duration)
                TitleExView(title: "Intensité")
                IntensityPickerExView(pickerTitle: "")
                TitleExView(title: "Nombre de calories brulées")
                NonObligatoryFieldExView()
                NumberFieldExView(textFieldTitle: "Nombre de calories brulées", textUnit: "cal", textInTextField: $caloriesBurned)
                ErrorMessageExView(errorMessage: $errorMessage)
            }
            Spacer()
            Button(action: {
                let tempsPhysicalActivity : PhysicalActivity = PhysicalActivity(date: date, duration: Double(duration) ?? 0, caloriesBurned: Double(caloriesBurned) ?? 0, idUser: userViewModel.user.id!, idIntensity: intensityViewModel.selectedCategory.id!, idActivityType: activityType.id!)
                
                errorMessage = ""
                
                if !tempsPhysicalActivity.verifyDate() {
                    errorMessage = "Mauvaise Date, veuillez rentrer une date qui n'est pas déjà passé"
                }
                
                if !tempsPhysicalActivity.verifyDuration() {
                    errorMessage = "Mauvaise Durée, veuillez rentrer une durée supérieur à 0"
                }
                
                if errorMessage == "" && Double(caloriesBurned) ?? 0 <= 0{
                    tempsPhysicalActivity.calculateCaloriesBurned(caloriesBurnedPerHour: activityType.caloriesBurnedPerHour, intensity : intensityViewModel.intensitys.first(where: {
                        $0.id == tempsPhysicalActivity.idIntensity
                    })?.name ?? "Pas d'intensité")
                }
                    
                if errorMessage == "" {
                    physicalActivityViewModel.create(physicalActivity: tempsPhysicalActivity)
                    dismiss()
                }
            }, label: {
                GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
            })
        }
        .padding()
        .navigationTitle("Ajouter une séance de :")
    }
}

#Preview {
    AddSpecificActivityView(activityType: ActivityType(name: "", caloriesBurnedPerHour: 0, image: ""))
}
