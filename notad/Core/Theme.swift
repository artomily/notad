//
//  Theme.swift
//  notad
//
//  Created by yourbaemac on 05/09/26.
//

import SwiftUI

enum Theme {
    static let accent = Color(red: 0.95, green: 0.40, blue: 0.20)
    
    static let heroGradient = LinearGradient(
        colors : [Color(red: 0.98, green: 0.45, blue: 0.20),
         Color(red: 0.94, green: 0.28, blue: 0.35)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing,
        )
    
    static let cardRadius: CGFloat = 20
    static let cardPadding: CGFloat = 10
}





