//
//  FilterModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 16/12/2024.
//

import Foundation

class Filter {
    var activity : String?
    var date : Date?
    var temporalRelation : TemporalRelation?
    var sortMethod : SortMethod?
    
    init(activity: String? = nil, date: Date? = nil, temporalRelation: TemporalRelation? = nil, sortMethod: SortMethod? = nil) {
        self.activity = activity
        self.date = date
        self.temporalRelation = temporalRelation
        self.sortMethod = sortMethod
    }
}
