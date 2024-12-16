//
//  MealExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 13/12/2024.
//

import SwiftUI

struct MealExView: View {
    @EnvironmentObject var mealTypeViewModel : MealTypeViewModel
    @State var meal : Meal?
    var buttonHeight : CGFloat = 120
    var buttonWidth : CGFloat = 80
    var lineHeight : CGFloat = 6
    var cornerRadius : CGFloat = 10
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.zfMediumGray)
                .offset(y : 4)
            VStack(spacing: 0) {
                AsyncImage(url: URL(string : meal?.name ?? "No Value")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width : buttonWidth, height : (buttonHeight/3*2) - lineHeight)
                        .clipShape(
                            UnevenRoundedRectangle(topLeadingRadius: cornerRadius, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: cornerRadius)
                        )
                } placeholder: {
                    Image(systemName: "plus")
                        .foregroundStyle(.zfOrange)
                        .bold()
                        .font(.system(size: buttonHeight * 0.4))
                        .frame(width : buttonWidth, height : (buttonHeight/3*2) - lineHeight)
                        .clipShape(
                            UnevenRoundedRectangle(topLeadingRadius: cornerRadius, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: cornerRadius)
                        )
                }
                Rectangle()
                    .foregroundStyle(.zfOrange)
                    .frame(height: lineHeight)
                ZStack {
                    UnevenRoundedRectangle(topLeadingRadius:0, bottomLeadingRadius: cornerRadius, bottomTrailingRadius: cornerRadius, topTrailingRadius: 0)
                        .foregroundStyle(.white)
                        .frame(height: (buttonHeight/3) - lineHeight)
                    Text(mealTypeViewModel.mealTypes.first(where: {
                        $0.id == meal?.idMealType
                    })?.name ?? "No Value")
                    .bold()
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    MealExView()
}