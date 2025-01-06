//
//  NonObligatoryFieldExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 17/12/2024.
//

import SwiftUI

struct LittleTextExView: View {
    let textToDisplay : String
    
    var body: some View {
        Text(textToDisplay)
            .foregroundStyle(.gray)
            .font(.system(size: 12))
    }
}

#Preview {
    LittleTextExView(textToDisplay: "Test")
}
