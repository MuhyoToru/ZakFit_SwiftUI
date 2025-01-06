//
//  DateSelectorExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct ChosenPeriodPickerExView: View {
    @EnvironmentObject var chosenPeriodViewModel : ChosenPeriodViewModel
    let pickerTitle : String
    
    var body: some View {
        HStack {
            Text(pickerTitle)
                .bold()
            Spacer()
            Picker(pickerTitle, selection: $chosenPeriodViewModel.selectedCategory) {
                ForEach(chosenPeriodViewModel.chosenPeriods) { chosenPeriod in
                    Text(chosenPeriod.name).tag(chosenPeriod)
                }
            }
            .pickerStyle(.automatic)
        }
    }
}

//#Preview {
//    AlimentPickerExView(needToBeUpdateCreate: .constant(true), alimentQuantity: AlimentQuantity(quantity: 0, weightOrUnit: "weight", idAliment: UUID()), pickerTitle: "Test", idMeal: UUID())
//}
