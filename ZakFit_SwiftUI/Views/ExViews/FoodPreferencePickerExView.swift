//
//  DateSelectorExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct FoodPreferencePickerExView: View {
    @EnvironmentObject var foodPreferenceViewModel: FoodPreferenceViewModel
    let pickerTitle: String
    
    var body: some View {
        HStack {
            Text(pickerTitle)
                .bold()
            Spacer()
            Picker(pickerTitle, selection: $foodPreferenceViewModel.selectedCategory) {
                ForEach(foodPreferenceViewModel.foodPreferences) { foodPreference in
                    Text(foodPreference.name).tag(foodPreference)
                }
            }
            .pickerStyle(.menu)
        }
    }
}

#Preview {
    FoodPreferencePickerExView(pickerTitle: "Test")
}
