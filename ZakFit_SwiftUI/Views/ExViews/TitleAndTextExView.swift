//
//  TitleExView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 11/12/2024.
//

import SwiftUI

struct TitleAndTextExView: View {
    var imageSystem : String?
    var title : String
    var textToDisplay : String
    var textUnit : String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            TitleExView(imageSystem: imageSystem, title: title)
            HStack {
                Text(textToDisplay)
                if textUnit != nil {
                    Text(textUnit!)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    TitleAndTextExView(imageSystem: "trash", title: "Compte", textToDisplay: "Ceci est un test")
}
