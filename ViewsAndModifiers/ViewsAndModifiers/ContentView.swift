//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Alfonso Acosta on 2024-09-19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .background(.red)
            .padding()
            .background(.blue)
            .padding()
            .background(.green)
            .padding()
            .background(.yellow)
    }
}

#Preview {
    ContentView()
}
