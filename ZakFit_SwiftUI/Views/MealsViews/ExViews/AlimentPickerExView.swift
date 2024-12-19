//
//  DateSelectorExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import SwiftUI

struct AlimentPickerExView: View {
    @EnvironmentObject var alimentViewModel : AlimentViewModel
    @StateObject var alimentQuantityViewModel = AlimentQuantityViewModel()
    @StateObject var alimentViewModelPrivate = AlimentViewModel()
    @Binding var needToBeUpdateCreate : String
    @State var alimentQuantity : AlimentQuantity
    @State var quantity : String = ""
    @State var weightOrUnit : String = "weight"
    @State var errorMessage : String = ""
    let pickerTitle : String
    let idMeal : UUID
    
    var body: some View {
        HStack {
            Picker(pickerTitle, selection: $alimentViewModelPrivate.selectedCategory) {
                ForEach(alimentViewModelPrivate.aliments) { aliment in
                    Text(aliment.name).tag(aliment)
                }
            }
            .pickerStyle(.automatic)
            .frame(width: 150)
            NumberFieldExView(textFieldTitle: "Combien ?", textUnit: "", textInTextField: $quantity)
            Button(action: {
                if weightOrUnit == "weight" {
                    weightOrUnit = "unit"
                } else if weightOrUnit == "unit" {
                    weightOrUnit = "weight"
                }
            }, label: {
                VStack {
                    Text(weightOrUnit == "weight" ? "kg" : "unité")
                    HStack {
                        Image(systemName: "chevron.left")
                        Image(systemName: "chevron.right")
                    }
                    .font(.system(size: 12))
                }
                .frame(width : 40)
            })
        }
        .onAppear(perform: {
            alimentViewModelPrivate.aliments = alimentViewModel.aliments
            alimentViewModelPrivate.selectedCategory = alimentViewModelPrivate.aliments.first(where: {
                $0.id == alimentQuantity.idAliment
            }) ?? Aliment(name: "Pas d'aliment", description: "", image: "")
            
            quantity = String(alimentQuantity.quantity)
            weightOrUnit = alimentQuantity.weightOrUnit
        })
        .onChange(of: needToBeUpdateCreate, {
            let tempAlimentQuantity = AlimentQuantity(id: alimentQuantity.id, quantity: Double(quantity)!, weightOrUnit: weightOrUnit, idAliment: alimentViewModelPrivate.selectedCategory.id!)
            
            if needToBeUpdateCreate == "waitingAlimentQuantity" {
                errorMessage = ""
                
                if !tempAlimentQuantity.verifyQuantity() {
                    errorMessage = "Quantité invalide, veuillez rentrer une quantité supérieur à 0"
                }
                
                if !tempAlimentQuantity.verifyWeightOrUnit() {
                    errorMessage = "Unité invalide, veuillez rentrer sélectionner une unité"
                }
                
                if errorMessage == "" {
                    needToBeUpdateCreate = "verifyAlimentQuantityDone"
                }
            } else if needToBeUpdateCreate == "mealDone" {
                if alimentQuantity.quantity == 0 {
                    alimentQuantityViewModel.create(alimentQuantity : tempAlimentQuantity, idMeal: idMeal)
                    needToBeUpdateCreate = "allDone"
                } else {
                    alimentQuantityViewModel.update(oldAlimentQuantity: alimentQuantity, newAlimentQuantity: tempAlimentQuantity)
                    needToBeUpdateCreate = "allDone"
                }
            }
        })
    }
}

//#Preview {
//    AlimentPickerExView(needToBeUpdateCreate: .constant(true), alimentQuantity: AlimentQuantity(quantity: 0, weightOrUnit: "weight", idAliment: UUID()), pickerTitle: "Test", idMeal: UUID())
//}
