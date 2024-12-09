//
//  DateSelectorExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct GenderPickerExView: View {
    @StateObject var genderViewModel: GenderViewModel
    let pickerTitle: String
    
    var body: some View {
        HStack {
            Text(pickerTitle)
                .bold()
            Spacer()
            Picker(pickerTitle, selection: $genderViewModel.selectedCategory) {
                ForEach(genderViewModel.genders) { gender in
                    Text(gender.name).tag(gender)
                }
            }
            .pickerStyle(.menu)
        }
    }
}

#Preview {
    GenderPickerExView(genderViewModel: GenderViewModel(), pickerTitle: "Test")
}
