//
//  DateSelectorExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct ActivityTypePickerExView: View {
    @EnvironmentObject var activityTypeViewModel: ActivityTypeViewModel
    let pickerTitle: String
    
    var body: some View {
        HStack {
            Text(pickerTitle)
                .bold()
            Spacer()
            Picker(pickerTitle, selection: $activityTypeViewModel.selectedCategory) {
                ForEach(activityTypeViewModel.activityTypes) { activityType in
                    Text(activityType.name).tag(activityType)
                }
            }
            .pickerStyle(.menu)
        }
    }
}

#Preview {
    ActivityTypePickerExView(pickerTitle: "Test")
}
