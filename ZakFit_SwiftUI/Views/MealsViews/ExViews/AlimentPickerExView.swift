//
//  DateSelectorExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct AlimentPickerExView: View {
    @EnvironmentObject var alimentViewModel: AlimentViewModel
    @StateObject var alimentQuantityViewModel = AlimentQuantityViewModel()
    @StateObject var alimentViewModelPrivate = AlimentViewModel()
    @Binding var needToBeUpdateCreate : Bool
    @State var alimentQuantity : AlimentQuantity
    @State var howMany : String = ""
    @State var weightOrUnit : String = "weight"
    let pickerTitle: String
    
    var body: some View {
        HStack {
            Picker(pickerTitle, selection: $alimentViewModelPrivate.selectedCategory) {
                ForEach(alimentViewModelPrivate.aliments) { aliment in
                    Text(aliment.name).tag(aliment)
                }
            }
            .pickerStyle(.automatic)
            .frame(width: 150)
            NumberFieldExView(textFieldTitle: "Combien ?", textUnit: "", textInTextField: $howMany)
            Text(weightOrUnit == "weight" ? "kg" : "unité")
                .frame(width : 40)
        }
        .onAppear(perform: {
            alimentViewModelPrivate.aliments = alimentViewModel.aliments
            alimentViewModelPrivate.selectedCategory = alimentViewModelPrivate.aliments.first(where: {
                $0.id == alimentQuantity.idAliment
            }) ?? Aliment(name: "Pas d'aliment", description: "", image: "")
        })
        .onChange(of: needToBeUpdateCreate, {
            if needToBeUpdateCreate {
                needToBeUpdateCreate = false
//                alimentQuantity.create()
            }
        })
    }
}

#Preview {
    AlimentPickerExView(needToBeUpdateCreate: .constant(true), alimentQuantity: AlimentQuantity(quantity: 0, weightOrUnit: "weight", idAliment: UUID()), pickerTitle: "Test")
}
