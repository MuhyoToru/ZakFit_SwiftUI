//
//  ActivityDetails.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 12/12/2024.
//

import SwiftUI

struct ActivityDetails: View {
    @EnvironmentObject var activityTypeViewModel: ActivityTypeViewModel
    @EnvironmentObject var intensityViewModel: IntensityViewModel
    @State var physicalActivity : PhysicalActivity
    
    @State var dateActivity : Date = Date.now
    @State var dateActivityCalendar : DateComponents = DateComponents()
    
    var imageHeight : CGFloat = 240
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: URL(string : activityTypeViewModel.activityTypes.first(where: {
                    $0.id == physicalActivity.idActivityType
                })?.image ?? "ZF_noImage")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageHeight * (16/9), height: imageHeight)
                        .clipShape(
                            Rectangle()
                        )
                } placeholder: {
                    Image("ZF_noImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageHeight * (16/9), height: imageHeight)
                        .clipShape(
                            Rectangle()
                        )
                }
                Rectangle()
                    .fill(Gradient(colors: [.white, .clear, .white]))
                    .frame(height : imageHeight)
                Text(activityTypeViewModel.activityTypes.first(where: {
                    $0.id == physicalActivity.idActivityType
                })?.name ?? "No Activity Name")
                .bold()
                .font(.title)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.zfOrange)
                            .padding(-8)
                            .offset(y : 4)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .padding(-8)
                    }
                )
            }
            HStack {
                VStack(alignment : .leading, spacing: 20) {
                    TitleAndTextExView(imageSystem: "calendar", title: "Date", textToDisplay: "\(dateActivityCalendar.day ?? 0) \(dateActivityCalendar.month?.intToMonth() ?? "") \(dateActivityCalendar.year ?? 0)")
                    TitleAndTextExView(imageSystem: "clock", title: "Durée", textToDisplay: physicalActivity.duration.doubleToHourDisplay())
                    TitleAndTextExView(imageSystem: "gauge.with.dots.needle.bottom.100percent", title: "Intensité", textToDisplay: intensityViewModel.intensitys.first(where: {
                        $0.id == physicalActivity.idIntensity
                    })?.name ?? "No Activity Name")
                    TitleAndTextExView(imageSystem: "flame.fill", title: "Calories Brulées", textToDisplay: String(physicalActivity.caloriesBurned))
                }
                Spacer()
            }
            .padding()
            Spacer()
            if physicalActivity.date > Date.now {
                NavigationLink(destination: {
                    EditActivityView(physicalActivity: physicalActivity)
                }, label: {
                    GeneralButtonDisplayExView(textToDisplay: "Editer", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160, imageSystem: "pencil")
                })
                Spacer()
            }       }
        .onAppear(perform: {
            dateActivity = physicalActivity.date
            dateActivityCalendar = Calendar.current.dateComponents([.year, .month, .day], from: dateActivity)
        })
    }
}

#Preview {
    ActivityDetails(physicalActivity: PhysicalActivity(date: Date.now + TimeInterval(60 * 60 * 24 * 3), duration: 0, caloriesBurned: 0, idUser: UUID(), idIntensity: UUID(), idActivityType: UUID()))
}