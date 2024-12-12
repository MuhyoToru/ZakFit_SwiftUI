//
//  ActivitysView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 11/12/2024.
//

import SwiftUI

struct ActivitysView: View {
    @EnvironmentObject var physicalActivityViewModel : PhysicalActivityViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TitleExView(title: "Prochainement")
                ScrollView(.horizontal) {
                    ForEach(physicalActivityViewModel.physicalActivitys) { physicalActivity in
                        Button(action: {
                            
                        }, label: {
                            PhysicalAvtivityDisplayExView(physicalActivity: physicalActivity)
                        })
                    }
                    .padding()
                }
                Button(action: {
                    
                }, label: {
                    GeneralButtonDisplayExView(textToDisplay: "Ajouter", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160, imageSystem: "plus")
                })
                TitleExView(title: "Recommandations")
                ScrollView(.horizontal) {
                    ForEach(physicalActivityViewModel.physicalActivitys) { physicalActivity in
                        Button(action: {
                            
                        }, label: {
                            PhysicalAvtivityDisplayExView(physicalActivity: physicalActivity)
                        })
                    }
                    .padding()
                }
                TitleExView(title: "Dernières activités faites")
                ScrollView(.horizontal) {
                    ForEach(physicalActivityViewModel.physicalActivitys) { physicalActivity in
                        Button(action: {
                            
                        }, label: {
                            PhysicalAvtivityDisplayExView(physicalActivity: physicalActivity)
                        })
                    }
                    .padding()
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
