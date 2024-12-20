//
//  AlimentQuantityDetailsExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 17/12/2024.
//

import SwiftUI

struct AlimentQuantityDetailsExView: View {
    @EnvironmentObject var alimentViewModel : AlimentViewModel
    var alimentQuantity : AlimentQuantity
    let imageSize : CGFloat = 60
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: alimentViewModel.aliments.first(where: {
                $0.id == alimentQuantity.idAliment
            })?.image ?? "ZF_noImage")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width : imageSize, height : imageSize)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
            } placeholder: {
                Image("ZF_noImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width : imageSize, height : imageSize)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
            }
            Spacer()
                .frame(width: 16)
            Text(alimentViewModel.aliments.first(where: {
                $0.id == alimentQuantity.idAliment
            })?.name ?? "Pas d'aliment")
            Spacer()
            Text(String(alimentQuantity.quantity))
            Text(alimentQuantity.weightOrUnit == "weight" ? "kg" : "unité")
        }
        .padding(.horizontal)
    }
}

#Preview {
    AlimentQuantityDetailsExView(alimentQuantity: AlimentQuantity(quantity: 0, weightOrUnit: "", idAliment: UUID()))
}
