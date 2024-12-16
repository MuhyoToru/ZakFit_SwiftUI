//
//  IntToHourDisplayExtension.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 13/12/2024.
//

import Foundation

extension Double {
    func doubleToHourDisplay() -> String {
        let hour : Int = Int(self)
        let minute : Int = Int((self - Double(hour)) * 60)
        
        if String(minute).count == 2 {
            return "\(hour)h\(minute)"
        } else {
            return "\(hour)h0\(minute)"
        }
    }
}
