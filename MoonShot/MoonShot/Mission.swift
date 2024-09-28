//
//  Mission.swift
//  MoonShot
//
//  Created by Alfonso Acosta on 2024-09-21.
//
import SwiftUI


struct Mission: Codable, Identifiable {

    struct CrewRole: Codable{
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date? //automatically skips over if value is missing //need to change Date
    let crew: [CrewRole]
    let description: String
    
    var displayName: String{
        "Apollo \(id)"
    }
    
    var image: String{
        "apollo\(id)"                              //adding computed proprties to easily display information
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A" //another computer property since we cant pass launchdate in text anymore since it is of type Date
    }
}
