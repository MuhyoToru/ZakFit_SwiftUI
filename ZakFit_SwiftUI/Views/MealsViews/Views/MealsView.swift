//
//  MealsView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 13/12/2024.
//

import SwiftUI

struct MealsView: View {
//    @EnvironmentObject var mealViewModel : MealViewModel
    @EnvironmentObject var mealTypeViewModel : MealTypeViewModel
    @State var daysArray : [Date] = []
    
    var numberOfDayToDisplay : Int = 7
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    ForEach(daysArray, id : \.self) { day in
                        let dayCalendar : DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: day)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                TitleExView(title: "\(dayCalendar.day ?? 0) \(dayCalendar.month?.intToMonth() ?? "") \(dayCalendar.year ?? 0)")
                                Spacer()
                            }
                            .padding(.horizontal)
                            HStack {
                                Spacer()
                                MealsRowExViews(dateToFetch: day)
                                Spacer()
                            }
                        }
                    }
                    NavigationLink(destination: {
                        
                    }, label: {
                        GeneralButtonDisplayExView(textToDisplay: "Ajouter un repas un autre jour", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 240, height: 72, imageSystem: "plus")
                    })
                    NavigationLink(destination: {
                        PastMealsView()
                    }, label: {
                        GeneralButtonDisplayExView(textToDisplay: "Voir les jours passés", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 240)
                    })
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Repas")
            .onAppear(perform: {
//                mealViewModel.fetch(filters: Filter())
                
                let time : TimeInterval = 60 * 60 * 24
                daysArray = []
                for i in 0...(numberOfDayToDisplay - 1) {
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
