//
//  MealsView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 13/12/2024.
//

import SwiftUI

struct PastMealsView: View {
    @EnvironmentObject var mealTypeViewModel : MealTypeViewModel
    @State var daysArray : [Date] = []
    @State var numberOfDayToDisplay : Int = 7
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
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
                            PastMealsRowExViews(dateToFetch: day)
                            Spacer()
                        }
                    }
                }
                Button(action: {
                    dismiss()
                }, label: {
                    GeneralButtonDisplayExView(textToDisplay: "Voir les jours à venir", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 240)
                })
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Repas passés")
        .onAppear(perform: {
            let time : TimeInterval = 60 * 60 * 24
            daysArray = []
            for i in 1...(numberOfDayToDisplay) {
                let day = Date.now - (time * Double(i))
                daysArray.append(day)
            }
        })
    }
}

//#Preview {
//    PastMealsView()
//}
