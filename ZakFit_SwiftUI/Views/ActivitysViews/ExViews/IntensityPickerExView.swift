//
//  DateSelectorExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct IntensityPickerExView: View {
    @EnvironmentObject var intensityViewModel: IntensityViewModel
    let pickerTitle: String
    
    var body: some View {
        HStack {
            Text(pickerTitle)
                .bold()
            Spacer()
            Picker(pickerTitle, selection: $intensityViewModel.selectedCategory) {
                ForEach(intensityViewModel.intensitys) { intensity in
                    Text(intensity.name).tag(intensity)
                }
            }
            .pickerStyle(.menu)
        }
    }
}

#Preview {
    IntensityPickerExView(pickerTitle: "Test")
}
