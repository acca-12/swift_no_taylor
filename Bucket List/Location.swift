//
//  Location.swift
//  Bucket List
//
//  Created by Alfonso Acosta on 2024-09-24.
//

import Foundation
import MapKit

//Identifiable to create many location marks, Codable to load and sav map data easily, Equatable to find one particular location in an array of locations
struct Location: Codable, Equatable, Identifiable{
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    //when making custom data types for use with SwiftUI, it is good practice to add a static example property
    #if DEBUG
        static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000 lightbulbs.", latitude: 51.501, longitude: -0.141)
    #endif
    
    //since location conforms to Equatable, can compare to locations with ==, but this by default would compare each value in our struct
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    } //instead we make our own definition of equality
}

