//
//  RegisterView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var userViewModel : UserViewModel = UserViewModel()
    @StateObject var genderViewModel: GenderViewModel = GenderViewModel()
    
//    @State var name : String = ""
//    @State var firstname : String = ""
//    @State var email : String = ""
//    @State var birthday : Date = Date.now
    @State var size : String = ""
    @State var weight : String = ""
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
            //NumberFieldExView(textFieldTitle: "Taille", textUnit: "m", textInTextField: $userViewModel.user.size)
            //NumberFieldExView(textFieldTitle: "Poids", textUnit: "kg", textInTextField: $weight)
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
                if !userViewModel.user.verifyPasswordConfirmation(password: password, confirmPassword: confirmPassword) {
                    errorMessage = "Mauvaise confirmation de Mot de passe"
                }
                errorMessage = userViewModel.user.verifyPassword(password: password)
                if errorMessage == "ok" {
                    errorMessage = ""
                }
                if !userViewModel.user.verifyEmail() {
                    errorMessage = "Email invalide"
                }
            }, label: {
                GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
            })
        }
        .onAppear {
            genderViewModel.fetchGenders()
        }
    }
}

#Preview {
    RegisterView()
}
