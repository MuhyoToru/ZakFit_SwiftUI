//
//  TextFieldExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct TextFieldExView: View {
    var textFieldTitle : String
    @Binding var textInTextField : String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.zfDarkGray, lineWidth: 2)
                .fill(.white)
            HStack {
                TextField(textFieldTitle, text: $textInTextField)
                    .keyboardType(.default)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Spacer()
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
    TextFieldExView(textFieldTitle: "email", textInTextField: .constant(""))
}
