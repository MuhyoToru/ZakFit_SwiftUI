//
//  PhysicalAvtivityButtonExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 11/12/2024.
//

import SwiftUI

struct PhysicalActivityDisplayExView: View {
    @EnvironmentObject var activityTypeViewModel : ActivityTypeViewModel
    var physicalActivity : PhysicalActivity
    var buttonHeight : CGFloat = 120
    var buttonWidth : CGFloat = 120
    var lineHeight : CGFloat = 6
    var cornerRadius : CGFloat = 10
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.zfMediumGray)
                .offset(y : 4)
            VStack(spacing: 0) {
                AsyncImage(url: URL(string : activityTypeViewModel.activityTypes.first(where: {
                    $0.id == physicalActivity.idActivityType
                })?.image ?? "ZF_noImage")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width : buttonWidth, height : (buttonHeight/3*2) - lineHeight)
                        .clipShape(
                            UnevenRoundedRectangle(topLeadingRadius: cornerRadius, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: cornerRadius)
                        )
                } placeholder: {
                    Image("ZF_noImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
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
                    Text(activityTypeViewModel.activityTypes.first(where: {
                        $0.id == physicalActivity.idActivityType
                    })?.name ?? "No Intensity")
                    .bold()
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    PhysicalActivityDisplayExView(physicalActivity: PhysicalActivity(date: Date.now, duration: 0, caloriesBurned: 0, idUser: UUID(), idIntensity: UUID(), idActivityType: UUID()))
}
