//
//  PhysicalAvtivityButtonExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 11/12/2024.
//

import SwiftUI

struct NextPhysicalActivityDisplayExView: View {
    var physicalActivity : PhysicalActivity

    var today : Date = Date.now
    @State var activityDate : Date = Date.now
    @State var difference : DateComponents = DateComponents()
    
    var body: some View {
        ZStack {
            PhysicalActivityDisplayExView(physicalActivity: physicalActivity)
            VStack {
                HStack {
                    Spacer()
                    ZStack {
                        Text(String((difference.day ?? 0) + 1) + "J")
                            .bold()
                            .foregroundStyle(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .foregroundStyle(.white)
                                    .padding(-8)
                            )
                    }
                }
                Spacer()
            }
            .padding()
        }
        .onAppear(perform: {
            activityDate = physicalActivity.date
            difference = Calendar.current.dateComponents([.day], from: today, to: activityDate)
        })
    }
}

#Preview {
    PastPhysicalActivityDisplayExView(physicalActivity: PhysicalActivity(date: Date.now + TimeInterval(60 * 60 * 24 * 3), duration: 0, caloriesBurned: 0, idUser: UUID(), idIntensity: UUID(), idActivityType: UUID()))
}
