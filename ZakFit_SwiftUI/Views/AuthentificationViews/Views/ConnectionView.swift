//
//  ConnectionView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct ConnectionView : View {
    @EnvironmentObject var userViewModel : UserViewModel
    @State var email : String = "pierreTest@gmail.com"
    @State var password : String = "AZer12+="
    
    var body: some View {
        TextFieldExView(textFieldTitle: "Email", textInTextField: $email)
        SecureFieldExView(secureFieldTitle: "Mot de passe", textInSecureField: $password)
        Spacer()
        Button(action: {
            userViewModel.login(email: email, password: password)
        }, label: {
            GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
        })
    }
}

#Preview {
    ConnectionView()
}
