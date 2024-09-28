//
//  SwiftUIView.swift
//  Bucket List
//
//  Created by Alfonso Acosta on 2024-09-24.
//

import SwiftUI



struct SwiftUIView: View {
    enum LoadingState{
        case loading, loaded, failed
    }
    @Environment(\.dismiss) var dismiss
    var location: Location

    @State private var name: String
    @State private var description: String
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()

    var onSave: (Location) -> Void //require a func to call where we can pass back whatever new location we want
    
    //@escaping means the func is being stashed away for user later on rather than being called immediately, needed since gets called when user presses save
    init(location: Location, onSave: @escaping(Location) -> Void) {
        self.location = location
        self.onSave = onSave
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
        //_ allows us to create an instance of the property wrapper not the data inside the wrapper
    }
        
    func fetchNearby() async{
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Bad")
            return
        }
        
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
        } catch {
            loadingState = .failed
        }
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
                
                Section("Nearby..."){
                    switch loadingState {
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic() //+ allows us to combne text views with different fonts as one large one
                        }
                    case .loading:
                        Text("Loading...")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    //since location is a class making a var copy lets us access existing data
                    var newLocation = location
                    newLocation.id  = UUID() //new UUID so swift can replace old one and make the change propgate through the state
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task{
                await fetchNearby()
            }//fetch when appear
        }
    }
}

#Preview {
    SwiftUIView(location: .example) {_ in} //trailing closure sytanx (works for last parameter)
}
