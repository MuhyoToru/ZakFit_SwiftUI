//
//  AccountView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 09/12/2024.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    
    var body: some View {
        Button(action: {
            userViewModel.logOut()
        }, label: {
            GeneralButtonDisplayExView(textToDisplay: "Déconnexion", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
        })
    }
}

#Preview {
    AccountView()
}
