//
//  ContentView.swift
//  Bucket List
//
//  Created by Alfonso Acosta on 2024-09-24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var locations = [Location]() //store locations
    @State private var selectedPlace: Location? //for customizability
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    var body: some View {
        MapReader{ proxy in //gives us map coordinates rather than screen
            Map(initialPosition: startPosition){
                ForEach(locations){ location in //show markers
                    Annotation(location.name, coordinate: location.coordinate) {/* CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)*/ //having to recalculate the coordinate each time is a bit annoying, so instead we will make it a computed property of location
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(.circle)
                            .onTapGesture {
                                selectedPlace = location
                                print("hello")
                            }
                        //can place any view for our marker
                    }
                }
                
            }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local){ //add markers on tap
                        let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                        locations.append(newLocation)
                    }
                }
                .sheet(item: $selectedPlace){ place in
                    SwiftUIView(location: place) { newLocation in
                        if let index = locations.firstIndex(of: place) {
                            locations[index] = newLocation
                            //updates location array so we can get the immediate change
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
