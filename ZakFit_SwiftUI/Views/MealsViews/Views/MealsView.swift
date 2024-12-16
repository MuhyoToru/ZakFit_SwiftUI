//
//  MealsView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 13/12/2024.
//

import SwiftUI

struct MealsView: View {
    @EnvironmentObject var mealViewModel : MealViewModel
    @EnvironmentObject var mealTypeViewModel : MealTypeViewModel
    @State var daysArray : [Date] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(daysArray, id : \.self) { day in
                        let dayCalendar : DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: day)
                        
                        VStack(alignment: .leading) {
                            TitleExView(title: "\(dayCalendar.day ?? 0) \(dayCalendar.month?.intToMonth() ?? "") \(dayCalendar.year ?? 0)")
                            HStack {
                                MealExView(meal : mealViewModel.meals.first(where: {
                                    day >= $0.date && day < $0.date + (60 * 60 * 24)
                                }))
                                MealExView(meal : mealViewModel.meals.first(where: {
                                    day >= $0.date && day < $0.date + (60 * 60 * 24)
                                }))
                                MealExView(meal : mealViewModel.meals.first(where: {
                                    day >= $0.date && day < $0.date + (60 * 60 * 24)
                                }))
                                MealExView(meal : mealViewModel.meals.first(where: {
                                    day >= $0.date && day < $0.date + (60 * 60 * 24)
                                }))
                            }
                        }
                    }
                    NavigationLink(destination: {
                        
                    }, label: {
                        GeneralButtonDisplayExView(textToDisplay: "Ajouter un repas", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 240, imageSystem: "plus")
                    })
                    NavigationLink(destination: {
                        PastMealsView()
                    }, label: {
                        GeneralButtonDisplayExView(textToDisplay: "Voir les jours passés", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 240)
                    })
                }
            }
            .padding(.horizontal)
            .navigationTitle("Repas")
            .onAppear(perform: {
                mealViewModel.fetch()
                
                let time : TimeInterval = 60 * 60 * 24
                for i in 1...7 {
                    let day = Date.now + (time * Double(i))
                    daysArray.append(day)
                }
            })
        }
    }
}

#Preview {
    MealsView(daysArray: [Date.now])
}
