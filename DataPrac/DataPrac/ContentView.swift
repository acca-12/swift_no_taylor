//
//  ContentView.swift
//  DataPrac
//
//  Created by Alfonso Acosta on 2024-09-22.
//


//@Binding lets us share a simple @State property of one view with another
import SwiftUI
import SwiftData
//custom ui that stays down when pressed
/*
struct PushButton: View {
    
    let title: String
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom))
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct ContentView: View {
    @State private var rememberMe = false
    //We defined a one-way flow of data:
    //ContentView has its rememberMe boolean, which gets used to create the button with the value we provided. but once its created then the button has control of this value internally and never passes it back
    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
            //why is it not changing (text) ?
        }
    }
}
 */
/*
struct ContentView: View {
    @AppStorage("notes") private var notes = ""

    
    //embedding text editor in some larger view is a good idea to ensure it doesn't go outside the safe area
    var body: some View {
        NavigationStack {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}
 */


//SwiftData is an object graph and persistence framework.
//this means it lets us define objects and their properties, then reads and write them from permanent storage

@Model //change from observable, model builds on top of the same observation system as observable!
class Student {
    var id: UUID
    var name: String

    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}



struct ContentView: View{
    @Query var students: [Student]
    //allows us to fetch and post results
    //this automatically loads all students from its model container
    @Environment(\.modelContext) var modelContext
    var body: some View{
        NavigationStack {
            List(students) { student in
                Text(student.name)
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!
                    let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
                    modelContext.insert(student)
                }
            }
        }
    }
}

//we can achieve the vertical expansion of a textfield like in iMessage by simmply passing its acis as vertical

#Preview {
    ContentView()
}
