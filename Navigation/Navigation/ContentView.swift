//
//  ContentView.swift
//  Navigation
//
//  Created by Alfonso Acosta on 2024-09-21.
//

import SwiftUI

struct ContentView: View {
    @State private var title = "SwiftUI"

    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
/*
@Observable
class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }

    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")

    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }

        // Still here? Start with an empty path.
        path = NavigationPath()
    }

    func save() {
        guard let representation = path.codable else { return }

        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

struct DetailView: View {
    var number: Int

    var body: some View {
        //autpmatiocallly apepends to patj
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
    }
}

struct ContentView: View {
    @State private var pathStore = PathStore()

    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailView(number: 0)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i)
                }
        }
    }
}

 */


/*
struct ContentView: View {
    
    
    //for more complex(combination of types perhaps, use the following
    @State private var path = NavigationPath()
    // works for simple data types @State private var path = [Int]()
    var body: some View {
        //changing path will automatically navigate to whatever is in the array
        NavigationStack(path: $path){
            VStack{
                Button("Show 32") {
                    // path = [32]
                    //goes back to original state
                    path.append(32)
                }

                Button("Show 64") {
                    path.append(64)
                    //goes back to original state
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
        }
    }
}
*/
//the problem with normal navigationLink:
//just showing the nav on the screen is enough for swift ui to automatically create a detail view existence

//navifationDestination() "when you're asked to navigate to the type in the parameter, here's what you should do...
//@Binding allows you to wrap an @State so that, it persits through views

//to save navstack path using codables we can make use ose
#Preview {
    ContentView()
}
