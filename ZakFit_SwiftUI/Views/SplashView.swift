//
//  SplashView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 13/12/2024.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.zfOrange
            Image("ZF_fullLogo")
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    SplashView()
}
