//
//  GeneralButtonDisplayExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct GeneralButtonDisplayExView: View {
    var textToDisplay : String
    var firstColor : Color
    var secondColor : Color
    var textColor : Color
    var width : CGFloat?
    var imageSystem : String?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(secondColor)
                .frame(height: 44)
                .offset(y: 4)
            RoundedRectangle(cornerRadius: 10)
                .fill(firstColor)
                .frame(height: 44)
            HStack {
                Text(textToDisplay)
                if imageSystem != nil {
                    Image(systemName: imageSystem!)
                }
            }
            .foregroundStyle(textColor)
            .bold()
            .font(.system(size: 24))
        }
        .frame(width: width)
    }
}

#Preview {
    GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 44)
}
