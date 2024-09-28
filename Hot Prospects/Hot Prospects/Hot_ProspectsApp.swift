//
//  Hot_ProspectsApp.swift
//  Hot Prospects
//
//  Created by Alfonso Acosta on 2024-09-24.
//

import SwiftUI

@main
struct Hot_ProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)//tells to allocate space for Prospect class but also shared a SwiftData model context into every SwiftUI view in our app
    }
}
