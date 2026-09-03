//
//  ParcedReceipt.swift
//  notad
//
//  Created by yourbaemac on 02/09/26.
//

import Foundation


struct ParsedReceipt: Equatable, Sendable{
    var merchant: String?
    var total: Int? //rupiah
    var date: Date?
}
