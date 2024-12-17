//
//  SortModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 16/12/2024.
//

import Foundation

class Sort {
    var byDate : Bool
    var byName : Bool
    
    init(byDate: Bool, byName: Bool) {
        self.byDate = true
        self.byName = false
    }
}
