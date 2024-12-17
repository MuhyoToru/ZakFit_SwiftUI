//
//  TitleExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 11/12/2024.
//

import SwiftUI

struct TitleExView: View {
    var imageSystem : String?
    var title : String
    
    var body: some View {
        HStack {
            if imageSystem != nil {
                Image(systemName: imageSystem!)
                    .frame(width: 28)
            }
            Text(title)
        }
        .font(.title2)
        .bold()
    }
}

#Preview {
    TitleExView(imageSystem: "trash", title: "Compte")
}
