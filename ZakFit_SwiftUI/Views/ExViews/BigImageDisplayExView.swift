//
//  BigImageDisplayExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 20/12/2024.
//

import SwiftUI

struct BigImageDisplayExView: View {
    let imageUrl : String
    let imageHeight : CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string : imageUrl)) { image in
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
    }
}
