//
//  RegisterView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var genderViewModel: GenderViewModel
    @EnvironmentObject var foodPreferenceViewModel: FoodPreferenceViewModel
    @Binding var selectedButton : String
    @State var name : String = ""
    @State var firstname : String = ""
    @State var email : String = ""
    @State var birthday : Date = Date.now
    @State var size : String = ""
    @State var notificationTime : String = "18:00"
    @State var password : String = ""
    @State var confirmPassword : String = ""
    
    @State var errorMessage : String = ""
    
    var body: some View {
        VStack {
            TextFieldExView(textFieldTitle: "Nom", textInTextField: $name)
            TextFieldExView(textFieldTitle: "Prénom", textInTextField: $firstname)
            TextFieldExView(textFieldTitle: "Email", textInTextField: $email)
            DatePickerExView(datePickerTitle: "Date de naissance", date: $birthday)
            GenderPickerExView(pickerTitle: "Genre")
            NumberFieldExView(textFieldTitle: "Taille", textUnit: "m", textInTextField: $size)
            FoodPreferencePickerExView(pickerTitle: "Préférence alimentaire")
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
                let tempUser : User = User(name: name, firstname: firstname, email: email, size: Double(size) ?? 0, birthday: birthday, notificationTime: notificationTime, idFoodPreference: foodPreferenceViewModel.selectedCategory.id, idGender: genderViewModel.selectedCategory.id)
                
                errorMessage = ""
                
                errorMessage = tempUser.verifyPassword(password: password)
                if errorMessage == "ok" {
                    errorMessage = ""
                }
                
                if !tempUser.verifyPasswordConfirmation(password: password, confirmPassword: confirmPassword) {
                    errorMessage = "Mauvaise confirmation de Mot de passe"
                }
                
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
                }
                
                if errorMessage == "" {
                    userViewModel.register(user: tempUser, password: password)
                    selectedButton = "Connexion"
                }
            }, label: {
                GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
            })
        }
        .onAppear {
            name = "Cilluffo"
            firstname = "Pierre"
            email = "pierreTest@gmail.com"
            size = "1.69"
            password = "AZer12+="
            confirmPassword = "AZer12+="
        }
    }
}

#Preview {
    RegisterView(selectedButton: .constant("S'inscrire"))
}
