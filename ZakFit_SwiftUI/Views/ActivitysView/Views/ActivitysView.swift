//
//  ActivitysView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 11/12/2024.
//

import SwiftUI

struct ActivitysView: View {
    @EnvironmentObject var physicalActivityViewModel : PhysicalActivityViewModel
    @EnvironmentObject var activityTypeViewModel : ActivityTypeViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView() {
                VStack(alignment : .leading) {
                    TitleExView(title: "Prochainement")
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(physicalActivityViewModel.physicalActivitys) { physicalActivity in
                                if physicalActivity.date > Date.now {
                                    NavigationLink(destination: {
                                        ActivityDetails(physicalActivity: physicalActivity)
                                    }, label: {
                                        NextPhysicalActivityDisplayExView(physicalActivity: physicalActivity)
                                    })
                                }
                            }
                            .padding(4)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                NavigationLink(destination: {
                    AddActivityView()
                }, label: {
                    GeneralButtonDisplayExView(textToDisplay: "Ajouter", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160, imageSystem: "plus")
                })
                VStack(alignment : .leading) {
                    TitleExView(title: "Recommandations")
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(activityTypeViewModel.activityTypes) { activityType in
                                Button(action: {
                                    
                                }, label: {
                                    ActivityTypeDisplayExView(activityType: activityType)
                                })
                            }
                            .padding(4)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                VStack(alignment : .leading) {
                    TitleExView(title: "Dernières activités faites")
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(physicalActivityViewModel.physicalActivitys) { physicalActivity in
                                if physicalActivity.date < Date.now {
                                    Button(action: {
                                        
                                    }, label: {
                                        PastPhysicalActivityDisplayExView(physicalActivity: physicalActivity)
                                    })
                                }
                            }
                            .padding(4)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .padding()
            .navigationTitle("Activités")
        }
        .onAppear(perform: {
            physicalActivityViewModel.fetch()
        })
    }
}

#Preview {
    ActivitysView()
}
