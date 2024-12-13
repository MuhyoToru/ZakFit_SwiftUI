//
//  DateSelectorExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct DatePickerExView: View {
    var datePickerTitle : String
    @Binding var date : Date
    let timeInterval : TimeInterval = 60 * 60 * 24 * 365
    
    var body: some View {
        VStack {
            DatePicker(selection: $date, in: ...(Date.now + timeInterval), displayedComponents: .date) {
                Text(datePickerTitle)
                    .bold()
            }
        }
    }
}

#Preview {
    DatePickerExView(datePickerTitle: "Date de naissance", date: .constant(Date.now))
}
