//
//  RegisterView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @StateObject var genderViewModel: GenderViewModel = GenderViewModel()
    @StateObject var foodPreferenceViewModel: FoodPreferenceViewModel = FoodPreferenceViewModel()
    @StateObject var userWeightViewModel: UserWeightViewModel = UserWeightViewModel()
    @Binding var selectedButton : String
//    @State var userWeight : UserWeight = UserWeight(weight: 0, date: Date.now, idUser: UUID())
    @State var size : String = ""
//    @State var weight : String = ""
    @State var password : String = ""
    @State var confirmPassword : String = ""
    
    @State var errorMessage : String = ""
    
    var body: some View {
        VStack {
            TextFieldExView(textFieldTitle: "Nom", textInTextField: $userViewModel.user.name)
            TextFieldExView(textFieldTitle: "Prénom", textInTextField: $userViewModel.user.firstname)
            TextFieldExView(textFieldTitle: "Email", textInTextField: $userViewModel.user.email)
            DatePickerExView(datePickerTitle: "Date de naissance", birthDate: $userViewModel.user.birthday)
            GenderPickerExView(genderViewModel: genderViewModel, pickerTitle: "Genre")
            NumberFieldExView(textFieldTitle: "Taille", textUnit: "m", textInTextField: $size)
//            NumberFieldExView(textFieldTitle: "Poids", textUnit: "kg", textInTextField: $weight)
            FoodPreferencePickerExView(foodPreferenceViewModel: foodPreferenceViewModel, pickerTitle: "Préférence alimentaire")
            SecureFieldExView(secureFieldTitle: "Mot de passe", textInSecureField: $password)
            SecureFieldExView(secureFieldTitle: "Confirmer mot de passe", textInSecureField: $confirmPassword)
            if errorMessage != "" {
                HStack {
                    Image(systemName: "exclamationmark.triangle")
                    Text(errorMessage)
                }
                .foregroundStyle(.red)
            }
            Spacer()
            Button(action: {
                errorMessage = userViewModel.user.verifyPassword(password: password)
                if errorMessage == "ok" {
                    errorMessage = ""
                }
                
                if !userViewModel.user.verifyPasswordConfirmation(password: password, confirmPassword: confirmPassword) {
                    errorMessage = "Mauvaise confirmation de Mot de passe"
                }
                
//                if !userWeight.verifyWeight(weight: weight) {
//                    errorMessage = "Poids invalide, doit être supérieur à 0"
//                }
                
                if !userViewModel.user.verifySize(size: size) {
                    errorMessage = "Taille invalide, doit être supérieur à 0"
                }
                
                if !userViewModel.user.verifyEmail() {
                    errorMessage = "Email invalide"
                }
                
                if !userViewModel.user.verifyFirstname() {
                    errorMessage = "Prénom invalide, veuillez remplir le champ"
                }
                
                if !userViewModel.user.verifyName() {
                    errorMessage = "Nom invalide, veuillez remplir le champ"
                }
                
                if errorMessage == "" {
                    userViewModel.register(name: userViewModel.user.name, firstname: userViewModel.user.firstname, email: userViewModel.user.email, size: userViewModel.user.size, birthday: userViewModel.user.birthday, notificationTime: userViewModel.user.notificationTime, password: password, idFoodPreference: foodPreferenceViewModel.selectedCategory.id!, idGender: genderViewModel.selectedCategory.id!)
//                    userWeightViewModel.createUserWeight(weight: userWeight.weight)
                    selectedButton = "Connexion"
                }
            }, label: {
                GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
            })
        }
        .onAppear {
            genderViewModel.fetchGenders()
            foodPreferenceViewModel.fetchFoodPreferences()
            userViewModel.user.name = "Cilluffo"
            userViewModel.user.firstname = "Pierre"
            userViewModel.user.email = "pierreTest@gmail.com"
            size = "1.69"
//            weight = "50"
            password = "AZer12+="
            confirmPassword = "AZer12+="
        }
    }
}

#Preview {
    RegisterView(selectedButton: .constant("S'inscrire"))
}
