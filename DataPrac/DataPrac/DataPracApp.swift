//
//  DataPracApp.swift
//  DataPrac
//
//  Created by Alfonso Acosta on 2024-09-22.
//

import SwiftUI
import SwiftData

@main //tells swift this is what launches our aup
struct DataPracApp: App {
    var body: some Scene {
        WindowGroup { //app can be displayed in many windows
            ContentView()
        }
        .modelContainer(for: Student.self) //allows SwiftData to be available everywhere in our app
        //model container is SwiftData's name for where it stores data.
        //you also need model context to lead and change objects -- this modifier automatically creates it called the main context and gets stored in SwiftUI's env
    }
}
