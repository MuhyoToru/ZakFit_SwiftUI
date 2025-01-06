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
    
    @State var birthday : Date = Date.now
    @State var birtdayCalendar : DateComponents = DateComponents()
    
    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment : .leading, spacing: 20) {
                    TitleAndTextExView(imageSystem: "person.fill", title: "Nom", textToDisplay: userViewModel.user.name)
                    TitleAndTextExView(imageSystem: "person.fill", title: "Prénom", textToDisplay: userViewModel.user.firstname)
                    TitleAndTextExView(imageSystem: "at", title: "Email", textToDisplay: userViewModel.user.email)
                    TitleAndTextExView(imageSystem: "calendar", title: "Date de naissance", textToDisplay: "\(birtdayCalendar.day ?? 0) \(birtdayCalendar.month?.intToMonth() ?? "") \(birtdayCalendar.year ?? 0)")
                    TitleAndTextExView(imageSystem: "figure.stand.dress.line.vertical.figure", title: "Genre", textToDisplay: genderViewModel.genders.first{
                        $0.id == userViewModel.user.idGender
                    }?.name ?? "Pas de genre")
                    TitleAndTextExView(imageSystem: "figure.arms.open", title: "Taille", textToDisplay: String(userViewModel.user.size), textUnit: "m")
                    TitleAndTextExView(imageSystem: "figure", title: "Poids", textToDisplay: String(userWeightViewModel.userWeights.first?.weight ?? 0), textUnit: "kg")
                    TitleAndTextExView(imageSystem: "carrot.fill", title: "Préférence alimentaire", textToDisplay: foodPreferenceViewModel.foodPreferences.first{
                        $0.id == userViewModel.user.idFoodPreference
                    }?.name ?? "Pas de préférence alimentaire")
                    TitleAndTextExView(imageSystem: "clock", title: "Heure de notification", textToDisplay: userViewModel.user.notificationTime)
                }
                Spacer()
            }
            .padding(.horizontal)
        }
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
        .padding()
        .onAppear(perform: {
            userViewModel.getById()
            birthday = userViewModel.user.birthday
            birtdayCalendar = Calendar.current.dateComponents([.year, .month, .day], from: birthday)
        })
    }
}
#Preview {
    AccountView()
}
