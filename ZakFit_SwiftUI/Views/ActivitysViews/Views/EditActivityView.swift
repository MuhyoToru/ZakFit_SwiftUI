//
//  AddActivityView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 12/12/2024.
//

import SwiftUI

struct EditActivityView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var intensityViewModel : IntensityViewModel
    @EnvironmentObject var activityTypeViewModel : ActivityTypeViewModel
    @EnvironmentObject var physicalActivityViewModel : PhysicalActivityViewModel
    @State var physicalActivity : PhysicalActivity
    @State var date : Date = Date.now
    @State var duration : String = ""
    @State var caloriesBurned : String = ""
    @State var errorMessage : String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                TitleExView(imageSystem : "figure.run", title: "Activité")
                ActivityTypePickerExView(pickerTitle: "")
                TitleExView(imageSystem: "calendar", title: "Date de l'activité")
                DatePickerExView(datePickerTitle: "", date: $date)
                TitleExView(imageSystem: "clock", title: "Durée de l'activité")
                NumberFieldExView(textFieldTitle: "Durée de l'activité", textUnit: "h", textInTextField: $duration)
                TitleExView(imageSystem: "gauge.with.dots.needle.bottom.100percent", title: "Intensité")
                IntensityPickerExView(pickerTitle: "")
                TitleExView(imageSystem : "flame.fill", title: "Nombre de calories brulées")
                Text("Champ non obligatoire")
                    .foregroundStyle(.gray)
                    .font(.system(size: 12))
                NumberFieldExView(textFieldTitle: "Nombre de calories brulées", textUnit: "cal", textInTextField: $caloriesBurned)
                ErrorMessageExView(errorMessage: $errorMessage)
            }
            Spacer()
            Button(action: {
                let tempPhysicalActivity : PhysicalActivity = PhysicalActivity(date: date, duration: Double(duration) ?? 0, caloriesBurned: Double(caloriesBurned) ?? 0, idUser: userViewModel.user.id!, idIntensity: intensityViewModel.selectedCategory.id!, idActivityType: activityTypeViewModel.selectedCategory.id!)
                
                errorMessage = ""
                
                if !tempPhysicalActivity.verifyDate() {
                    errorMessage = "Mauvaise Date, veuillez rentrer une date qui n'est pas déjà passé"
                }
                
                if !tempPhysicalActivity.verifyDuration() {
                    errorMessage = "Mauvaise Durée, veuillez rentrer une durée supérieur à 0"
                }
                
                if errorMessage == "" && Double(caloriesBurned) ?? 0 <= 0{
                    tempPhysicalActivity.calculateCaloriesBurned(caloriesBurnedPerHour: activityTypeViewModel.activityTypes.first(where: {
                        $0.id == tempPhysicalActivity.idActivityType
                    })?.caloriesBurnedPerHour ?? 0, intensity : intensityViewModel.intensitys.first(where: {
                        $0.id == tempPhysicalActivity.idIntensity
                    })?.name ?? "Pas d'intensité")
                }
                
                if errorMessage == "" {
                    Task {
                        physicalActivityViewModel.update(oldPhysicalActivity: physicalActivity, newPhysicalActivity: tempPhysicalActivity)
                        dismiss()
                    }
                }
            }, label: {
                GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
            })
        }
        .padding()
        .navigationTitle("Editer l'activité")
        .navigationBarTitleDisplayMode(.large)
        .onAppear(perform: {
            date = physicalActivity.date
            duration = String(physicalActivity.duration)
            caloriesBurned = String(physicalActivity.caloriesBurned)
            
            activityTypeViewModel.selectedCategory = activityTypeViewModel.activityTypes.first {
                $0.id == physicalActivity.idActivityType
            } ?? ActivityType(name: "Pas d'activité", caloriesBurnedPerHour: 100, image: "ZF_noImage")
            
            intensityViewModel.selectedCategory = intensityViewModel.intensitys.first {
                $0.id == physicalActivity.idIntensity
            } ?? Intensity(name: "Pas d'intensité")
        })
    }
}

#Preview {
    EditActivityView(physicalActivity: PhysicalActivity(date: Date.now, duration: 2.75, caloriesBurned: 100, idUser: UUID(), idIntensity: UUID(), idActivityType: UUID()))
}
