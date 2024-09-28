//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Alfonso Acosta on 2024-09-22.
//

import SwiftUI

@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
