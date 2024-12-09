//
//  DateSelectorExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct DatePickerExView: View {
    var datePickerTitle : String
    @Binding var birthDate : Date
    
    var body: some View {
        VStack {
            DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                Text(datePickerTitle)
                    .bold()
            }
        }
    }
}

#Preview {
    DatePickerExView(datePickerTitle: "Date de naissance", birthDate: .constant(Date.now))
}
