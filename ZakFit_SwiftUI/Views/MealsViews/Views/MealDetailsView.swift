//
//  MealDetailsView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 16/12/2024.
//

import SwiftUI

struct MealDetailsView: View {
    @EnvironmentObject var mealTypeViewModel: MealTypeViewModel
    @EnvironmentObject var alimentViewModel : AlimentViewModel
    @StateObject var alimentQuantityViewModel = AlimentQuantityViewModel()
    @StateObject var mealViewModel = MealViewModel()
    @State var meal : Meal
    
    @State var dateMeal : Date = Date.now
    @State var dateMealCalendar : DateComponents = DateComponents()
    
    @Environment(\.dismiss) private var dismiss
    
    var imageHeight : CGFloat = 240
    
    var body: some View {
        VStack {
            ZStack {
                BigImageDisplayExView(imageUrl: meal.image ?? "", imageHeight: imageHeight)
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
                        TitleExView(imageSystem: "carrot.fill", title: "Ingrédients")
                        ForEach(alimentQuantityViewModel.alimentQuantitys) { alimentQuantity in
                            AlimentQuantityDetailsExView(alimentQuantity: alimentQuantity)
                        }
                    }
                    Spacer()
                }
            }
            .padding()
            if meal.date > Date.now - (60 * 60 * 24) {
                HStack {
                    NavigationLink(destination: {
                        EditMealView(meal: meal, date: Date.now, mealType: "")
                    }, label: {
                        GeneralButtonDisplayExView(textToDisplay: "Editer", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160, imageSystem: "pencil")
                    })
                    Button(action: {
                        mealViewModel.delete(meal: meal)
                        dismiss()
                    }, label: {
                        GeneralButtonDisplayExView(textToDisplay: "Supprimer", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160, imageSystem: "trash")
                    })
                }
            }
        }
        .onAppear(perform: {
            alimentQuantityViewModel.fetchByMealId(idMeal: meal.id!)
            
            dateMeal = meal.date
            dateMealCalendar = Calendar.current.dateComponents([.year, .month, .day], from: dateMeal)
        })
    }
}

#Preview {
    MealDetailsView(meal: Meal(name: "", image: "", date: Date.now, totalCalories: 0, totalProteins: 0, totalCarbohydrates: 0, totalLipids: 0, idMealType: UUID(), idUser: UUID()))
}
