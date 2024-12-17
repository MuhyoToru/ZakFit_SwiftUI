//
//  TextFieldExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct SecureFieldExView: View {
    var secureFieldTitle : String
    @Binding var textInSecureField : String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.zfDarkGray, lineWidth: 2)
                .fill(.white)
            HStack {
                SecureField(secureFieldTitle, text: $textInSecureField)
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
    SecureFieldExView(secureFieldTitle: "email", textInSecureField: .constant(""))
}
