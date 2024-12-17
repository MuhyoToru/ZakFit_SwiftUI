//
//  MealDetailsView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 16/12/2024.
//

import SwiftUI

struct MealDetailsView: View {
    @EnvironmentObject var mealTypeViewModel: MealTypeViewModel
    @StateObject var alimentQuantityViewModel = AlimentQuantityViewModel()
    @StateObject var alimentViewModel = AlimentViewModel()
    @State var meal : Meal
    
    @State var dateMeal : Date = Date.now
    @State var dateMealCalendar : DateComponents = DateComponents()
    
    var imageHeight : CGFloat = 240
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: URL(string : meal.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageHeight * (16/9), height: imageHeight)
                        .clipShape(
                            Rectangle()
                        )
                } placeholder: {
                    Image("ZF_noImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageHeight * (16/9), height: imageHeight)
                        .clipShape(
                            Rectangle()
                        )
                }
                Rectangle()
                    .fill(Gradient(colors: [.white, .clear, .white]))
                    .frame(height : imageHeight)
                Text(meal.name)
                    .bold()
                    .font(.title)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.zfOrange)
                                .padding(-8)
                                .offset(y : 4)
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .padding(-8)
                        }
                    )
            }
            ScrollView {
                HStack {
                    VStack(alignment : .leading, spacing: 20) {
                        TitleAndTextExView(imageSystem: "calendar", title: "Date du repas", textToDisplay: "\(dateMealCalendar.day ?? 0) \(dateMealCalendar.month?.intToMonth() ?? "") \(dateMealCalendar.year ?? 0)")
                        TitleAndTextExView(imageSystem: "clock", title: "Période du repas", textToDisplay: mealTypeViewModel.mealTypes.first(where: {
                            $0.id == meal.idMealType
                        })?.name ?? "Pas de période")
                        TitleExView(imageSystem: "flame.fill", title: "Apport énergétique")
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Calories :")
                                    .bold()
                                Spacer()
                                Text(String(meal.totalCalories))
                                Text("kcal")
                            }
                            HStack {
                                Text("Protéines :")
                                    .bold()
                                Spacer()
                                Text(String(meal.totalProteins))
                                Text("g")
                            }
                            HStack {
                                Text("Glucides :")
                                    .bold()
                                Spacer()
                                Text(String(meal.totalCarbohydrates))
                                Text("g")
                            }
                            HStack {
                                Text("Lipides :")
                                    .bold()
                                Spacer()
                                Text(String(meal.totalLipids))
                                Text("g")
                            }
                        }
                        .padding(.horizontal)
                        TitleExView(imageSystem: "carrot", title: "Ingrédients")
                    }
                    Spacer()
                }
            }
            .padding()
            Spacer()
            if meal.date > Date.now {
                NavigationLink(destination: {
                    EditMealView(meal: meal)
                }, label: {
                    GeneralButtonDisplayExView(textToDisplay: "Editer", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160, imageSystem: "pencil")
                })
                Spacer()
            }
        }
        .onAppear(perform: {
            dateMeal = meal.date
            dateMealCalendar = Calendar.current.dateComponents([.year, .month, .day], from: dateMeal)
        })
    }
}

#Preview {
    MealDetailsView(meal: Meal(name: "", image: "", date: Date.now, totalCalories: 0, totalProteins: 0, totalCarbohydrates: 0, totalLipids: 0, idMealType: UUID(), idUser: UUID()))
}