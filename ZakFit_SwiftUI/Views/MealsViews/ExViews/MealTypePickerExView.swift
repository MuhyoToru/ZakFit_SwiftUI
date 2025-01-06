//
//  DateSelectorExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct MealTypePickerExView: View {
    @EnvironmentObject var mealTypeViewModel: MealTypeViewModel
    let pickerTitle: String
    
    var body: some View {
        HStack {
            Text(pickerTitle)
                .bold()
            Spacer()
            Picker(pickerTitle, selection: $mealTypeViewModel.selectedCategory) {
                ForEach(mealTypeViewModel.mealTypes) { mealType in
                    Text(mealType.name).tag(mealType)
                }
            }
            .pickerStyle(.menu)
        }
    }
}

#Preview {
    MealTypePickerExView(pickerTitle: "Test")
}
