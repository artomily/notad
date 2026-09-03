//
//  notadApp.swift
//  notad
//
//  Created by yourbaemac on 02/09/26.
//

import SwiftUI
import SwiftData

@main
struct notadApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Receipt.self)
    }
}
