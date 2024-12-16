//
//  PhysicalAvtivityButtonExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 11/12/2024.
//

import SwiftUI

struct ActivityTypeDisplayExView: View {
    var activityType : ActivityType
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
                AsyncImage(url: URL(string: activityType.image)) { image in
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
                    Text(activityType.name)
                    .bold()
                    .foregroundStyle(.black)
                }
            }
            VStack {
                HStack {
                    Spacer()
                    ZStack {
                        Image(systemName: "plus")
                            .bold()
                            .foregroundStyle(.zfOrange)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .foregroundStyle(.zfMediumGray)
                                        .padding(-8)
                                        .offset(y : 4)
                                    RoundedRectangle(cornerRadius: 6)
                                        .foregroundStyle(.white)
                                        .padding(-8)
                                }
                            )
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    PhysicalActivityDisplayExView(physicalActivity: PhysicalActivity(date: Date.now, duration: 0, caloriesBurned: 0, idUser: UUID(), idIntensity: UUID(), idActivityType: UUID()))
}
