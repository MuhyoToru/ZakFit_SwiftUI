//
//  ConnectionView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct ConnectionView : View {
    @State var email : String = ""
    @State var password : String = ""
    
    var body: some View {
        TextFieldExView(textFieldTitle: "Email", textInTextField: $email)
        TextFieldExView(textFieldTitle: "Mot de passe", textInTextField: $password)
        Spacer()
        Button(action: {
            
        }, label: {
            GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
        })
    }
}

#Preview {
    ConnectionView()
}
