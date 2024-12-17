//
//  TextFieldExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct NumberFieldExView: View {
    var textFieldTitle : String
    var textUnit : String
    @Binding var textInTextField : String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.zfDarkGray, lineWidth: 2)
                .fill(.white)
            HStack {
                TextField(textFieldTitle, text: $textInTextField)
                    .keyboardType(.decimalPad)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                Spacer()
                Text(textUnit)
                Image(systemName: "pencil")
            }
            .foregroundStyle(.black)
            .bold()
            .padding(.horizontal)
        }
        .frame(height: 44)
    }
}

#Preview {
    NumberFieldExView(textFieldTitle: "Poids", textUnit : "kg", textInTextField: .constant(""))
}
