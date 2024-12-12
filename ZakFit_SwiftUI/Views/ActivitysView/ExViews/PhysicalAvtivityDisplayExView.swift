//
//  PhysicalAvtivityButtonExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 11/12/2024.
//

import SwiftUI

struct PhysicalAvtivityDisplayExView: View {
    @EnvironmentObject var intensityViewModel : IntensityViewModel
    var physicalActivity : PhysicalActivity
    var buttonHeight : CGFloat = 120
    var lineHeight : CGFloat = 6
    var cornerRadius : CGFloat = 10
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.zfMediumGray)
                .offset(y : 4)
            VStack(spacing: 0) {
                Image("ZF_fullLogo")
                    .resizable()
                    .scaledToFill()
                    .clipShape(
                        UnevenRoundedRectangle(topLeadingRadius: cornerRadius, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: cornerRadius)
                    )
                    .frame(height: (buttonHeight/3*2) - lineHeight)
                Rectangle()
                    .foregroundStyle(.zfOrange)
                    .frame(height: lineHeight)
                ZStack {
                    UnevenRoundedRectangle(topLeadingRadius:0, bottomLeadingRadius: cornerRadius, bottomTrailingRadius: cornerRadius, topTrailingRadius: 0)
                        .foregroundStyle(.white)
                        .frame(height: (buttonHeight/3) - lineHeight)
                    Text(intensityViewModel.intensitys.first(where: {
                        $0.id == physicalActivity.idIntensity
                    })?.name ?? "No Intensity")
                    .bold()
                    .foregroundStyle(.black)
                }
            }
        }
        .frame(width: 120, height: 120)
    }
}

#Preview {
    PhysicalAvtivityDisplayExView(physicalActivity: PhysicalActivity(date: Date.now, duration: 0, caloriesBurned: 0, idUser: UUID(), idIntensity: UUID()))
}
