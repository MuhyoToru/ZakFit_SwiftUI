//
//  EditAccountView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 11/12/2024.
//

import SwiftUI

struct EditAccountView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var genderViewModel : GenderViewModel
    @EnvironmentObject var userWeightViewModel : UserWeightViewModel
    @EnvironmentObject var foodPreferenceViewModel : FoodPreferenceViewModel
    @State var tempUser : User = User(name: "", firstname: "", email: "", size: 0, birthday: Date.now, notificationTime: "18:00")
    @State var tempWeight : UserWeight = UserWeight(weight: 0, date: Date.now)
    @State var size : String = ""
    @State var weight : String = ""
    @State var errorMessage : String = ""
    @State var animate : Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ErrorMessageExView(errorMessage: $errorMessage)
                    TitleExView(imageSystem: "person.fill", title: "Nom")
                    TextFieldExView(textFieldTitle: "Nom", textInTextField: $tempUser.name)
                    TitleExView(imageSystem: "person.fill", title: "Prénom")
                    TextFieldExView(textFieldTitle: "Prénom", textInTextField: $tempUser.firstname)
                    TitleExView(imageSystem: "at", title: "Email")
                    TextFieldExView(textFieldTitle: "Email", textInTextField: $tempUser.email)
                    TitleExView(imageSystem: "calendar", title: "Date de naissance")
                    DatePickerExView(datePickerTitle: "Date de naissance", birthDate: $tempUser.birthday)
                    TitleExView(imageSystem: "figure.arms.open", title: "Taille")
                    NumberFieldExView(textFieldTitle: "Taille", textUnit: "m", textInTextField: $size)
                    TitleExView(imageSystem: "figure", title: "Poids")
                    NumberFieldExView(textFieldTitle: "Poids", textUnit: "kg", textInTextField: $weight)
                    TitleExView(imageSystem: "figure.stand.dress.line.vertical.figure", title: "Genre")
                    GenderPickerExView(pickerTitle: "")
                    TitleExView(imageSystem: "carrot.fill", title: "Préference alimentaire")
                    FoodPreferencePickerExView(pickerTitle: "")
                    ErrorMessageExView(errorMessage: $errorMessage)
                }
                .padding()
            }
            Button(action: {
                errorMessage = ""
                
                if !tempUser.verifySize(size: size) {
                    errorMessage = "Taille invalide, doit être supérieur à 0"
                }
                
                if !tempUser.verifyEmail() {
                    errorMessage = "Email invalide"
                }
                
                if !tempUser.verifyFirstname() {
                    errorMessage = "Prénom invalide, veuillez remplir le champ"
                }
                
                if !tempUser.verifyName() {
                    errorMessage = "Nom invalide, veuillez remplir le champ"
                    print(errorMessage)
                }
                
                if !tempWeight.verifyWeight(weight: weight) {
                    errorMessage = "Poids invalide, doit être supérieur à 0"
                }
                
                if errorMessage == "" {
                    tempUser.idGender = genderViewModel.selectedCategory.id
                    tempUser.idFoodPreference = foodPreferenceViewModel.selectedCategory.id
                    userViewModel.update(user: tempUser)
                    
                    if userWeightViewModel.userWeights.first!.verifyDate() {
                        userWeightViewModel.create(weight: tempWeight.weight)
                    } else {
                        userWeightViewModel.update(userWeight: userWeightViewModel.userWeights.first!, newWeight: tempWeight.weight)
                    }
                    
                    dismiss()
                }
            }, label: {
                GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
            })
            .padding()
        }
        .navigationTitle("Editer Compte")
        .onAppear(perform: {
            tempUser.name = userViewModel.user.name
            tempUser.firstname = userViewModel.user.firstname
            tempUser.email = userViewModel.user.email
            tempUser.birthday = userViewModel.user.birthday
            tempUser.size = userViewModel.user.size
            size = String(tempUser.size)
            tempUser.notificationTime = userViewModel.user.notificationTime
            
            tempWeight.weight = userWeightViewModel.userWeights.first?.weight ?? 0
            weight = String(tempWeight.weight)
            tempWeight.idUser = userViewModel.user.id
            
            genderViewModel.selectedCategory = genderViewModel.genders.first {
                $0.id == userViewModel.user.idGender
            } ?? Gender(name: "Pas de genre")
            
            foodPreferenceViewModel.selectedCategory = foodPreferenceViewModel.foodPreferences.first {
                $0.id == userViewModel.user.idFoodPreference
            } ?? FoodPreference(name: "Pas de préférence alimentaire")
        })
    }
}

#Preview {
    EditAccountView()
}
