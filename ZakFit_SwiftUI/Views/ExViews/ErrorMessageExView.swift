//
//  ErrorMessageExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 11/12/2024.
//

import SwiftUI

struct ErrorMessageExView: View {
    @Binding var errorMessage : String
    @State var animated : Bool = true
    
    var body: some View {
        if errorMessage != "" {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                Text(errorMessage)
            }
            .foregroundStyle(.red)
            .onChange(of: errorMessage, {
                animated.toggle()
            })
            .animation(.bouncy, value: animated)
        }
    }
}

#Preview {
    ErrorMessageExView(errorMessage: .constant("Test"))
}
