//
//  DateSelectorExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct AlimentPickerExView: View {
    @EnvironmentObject var alimentViewModel : AlimentViewModel
    @StateObject var alimentViewModelPrivate = AlimentViewModel()
    @Binding var alimentQuantitys : [AlimentQuantity]
    @Binding var alimentQuantity : AlimentQuantity
    @State var quantity : String = ""
    let pickerTitle : String
    
    var body: some View {
        HStack {
            Picker(pickerTitle, selection: $alimentViewModelPrivate.selectedCategory) {
                ForEach(alimentViewModelPrivate.aliments) { aliment in
                    Text(aliment.name).tag(aliment)
                }
            }
            .pickerStyle(.automatic)
            .frame(width: 140)
            NumberFieldExView(textFieldTitle: "Combien ?", textUnit: "", textInTextField: Binding( get: { String(alimentQuantity.quantity) }, set: { newValue in
                    if let doubleValue = Double(newValue) {
                        alimentQuantity.quantity = doubleValue
                    }
                }
            ))
            Button(action: {
                if alimentQuantity.weightOrUnit == "weight" {
                    alimentQuantity.weightOrUnit = "unit"
                } else if alimentQuantity.weightOrUnit == "unit" {
                    alimentQuantity.weightOrUnit = "weight"
                }
            }, label: {
                VStack {
                    Text(alimentQuantity.weightOrUnit == "weight" ? "kg" : "unité")
                    HStack {
                        Image(systemName: "chevron.left")
                        Image(systemName: "chevron.right")
                    }
                    .font(.system(size: 12))
                }
                .frame(width : 44)
            })
            Button(action: {
                if alimentQuantitys.count >= 2 {
                    if let firstIndex = alimentQuantitys.firstIndex(of: alimentQuantity) {
                        alimentQuantitys.remove(at: firstIndex)
                    }
                }
            }, label: {
                GeneralButtonDisplayExView(firstColor: alimentQuantitys.count >= 2 ? .zfOrange : .zfMediumGray, secondColor: alimentQuantitys.count >= 2 ? .zfMediumGray : .zfDarkGray, textColor: alimentQuantitys.count >= 2 ? .white : .black, width: 44, imageSystem: "trash")
            })
        }
        .onAppear(perform: {
            alimentViewModelPrivate.aliments = alimentViewModel.aliments
            alimentViewModelPrivate.selectedCategory = alimentViewModelPrivate.aliments.first(where: {
                $0.id == alimentQuantity.idAliment
            }) ?? Aliment(name: "Pas d'aliment", description: "", image: "")
        })
        .onChange(of: alimentViewModelPrivate.selectedCategory, {
            alimentQuantity.idAliment = alimentViewModelPrivate.selectedCategory.id!
        })
    }
}

//#Preview {
//    AlimentPickerExView(needToBeUpdateCreate: .constant(true), alimentQuantity: AlimentQuantity(quantity: 0, weightOrUnit: "weight", idAliment: UUID()), pickerTitle: "Test", idMeal: UUID())
//}
