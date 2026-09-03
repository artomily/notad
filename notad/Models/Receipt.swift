//
//  Receipt.swift
//  notad
//
//  Created by yourbaemac on 03/09/26.
//

import Foundation
import SwiftData

@Model
final class Receipt {
    var merchant: String
    var total: Int
    var date: Date
    var createdAt: Date
    
    init(merchant: String, total: Int, date: Date, createdAt: Date = .now){
        self.merchant = merchant
        self.total = total
        self.date = date
        self.createdAt = createdAt
    }
}
