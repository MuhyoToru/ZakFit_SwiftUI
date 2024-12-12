//
//  AccountView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 09/12/2024.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var genderViewModel : GenderViewModel
    @EnvironmentObject var userWeightViewModel : UserWeightViewModel
    @EnvironmentObject var foodPreferenceViewModel : FoodPreferenceViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack(alignment : .leading, spacing: 20) {
                        TitleAndTextExView(imageSystem: "person.fill", title: "Nom", textToDisplay: userViewModel.user.name)
                        TitleAndTextExView(imageSystem: "person.fill", title: "Prénom", textToDisplay: userViewModel.user.firstname)
                        TitleAndTextExView(imageSystem: "at", title: "Email", textToDisplay: userViewModel.user.email)
//                        TitleAndTextExView(imageSystem: "calendar", title: "Date de naissance", textToDisplay: userViewModel.user.birthday)
                        TitleAndTextExView(imageSystem: "figure.stand.dress.line.vertical.figure", title: "Genre", textToDisplay: genderViewModel.genders.first{
                            $0.id == userViewModel.user.idGender
                        }?.name ?? "Pas de genre")
                        TitleAndTextExView(imageSystem: "figure.arms.open", title: "Taille", textToDisplay: String(userViewModel.user.size))
                        TitleAndTextExView(imageSystem: "figure", title: "Poids", textToDisplay: String(userWeightViewModel.userWeights.first?.weight ?? 0))
                        TitleAndTextExView(imageSystem: "carrot.fill", title: "Préference alimentaire", textToDisplay: foodPreferenceViewModel.foodPreferences.first{
                            $0.id == userViewModel.user.idFoodPreference
                        }?.name ?? "Pas de préférence alimentaire")
                    }
                    Spacer()
                }
                Spacer()
                HStack {
                    NavigationLink(destination: {
                        EditAccountView()
                    }, label: {
                        GeneralButtonDisplayExView(textToDisplay: "Editer Profil", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 180, imageSystem: "pencil")
                    })
                    Button(action: {
                        userViewModel.logOut()
                    }, label: {
                        GeneralButtonDisplayExView(textToDisplay: "Déconnexion", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
                    })
                }
            }
            .padding()
            .navigationTitle("Compte")
        }
    }
}

#Preview {
    AccountView()
}
