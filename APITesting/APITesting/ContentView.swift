//
//  ContentView.swift
//  APITesting
//
//  Created by Alfonso Acosta on 2024-09-21.
//

import SwiftUI







/*
struct Response: Codable{
    var results: [Result]
}

struct Result: Codable{
    var trackId: Int
    var trackName: String
    var collectionName: String
}



struct ContentView: View {
    @State private var results = [Result]()
    func loadData() async{ //mark functions that may go to sleep for a while with await
        print("Running")
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("URL DNE")
            return
        }
        
        do{
            //data(from :) method returns the Data object at that URL
            //returns a tuple of data and metadata of how req went
            let(data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
                results = decodedResponse.results
            }
            
        } catch {
            print("Invalid Data")
        }
    }
    var body: some View {
        List(results, id: \.trackId){ item in
            VStack(alignment: .leading){
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
                // AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"))
                //loads images from remote server
                //proper way to load images from remote server with customizability!
                //normally resizing and such doesn't work, since swift doesn't exactly know what to modify when we are asyncing
                AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Text("There was an error loading the image.")
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 200, height: 200)
            }
        }
        .task{
            await loadData() //marking that a sleep might happen
        }
    }
}
*/


struct ContentView: View {
    @State private var username = ""
    @State private var email = ""

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
            .disabled(username.isEmpty || email.isEmpty) //disables the form section
            //gray when disabled
        }
    }
}
/*
 @Observable
 class User: Codable {
     enum CodingKeys: String, CodingKey {
         case _name = "name"
     }

     var name = "Taylor"
 }
 
 for classes we  get funky stuff when we try storing it as a json
 we need to first let user follow the codable protocol
 
 next is to hand the weird naming: we need to tell swift exactly how to encode and decode
 this can be done by nesting an enum called CodingKeys which will ne a string and confirms
 to CodingKey next for each weird label we get we need to make a case to switch it to what we want to store

 */

//simple haptic effect: .sensoryFeedback(.increase, trigger: counter) trigger is what will cause it to happen


#Preview {
    ContentView()
}
