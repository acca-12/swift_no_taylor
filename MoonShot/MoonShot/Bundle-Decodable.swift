//
//  Bundle-Decodable.swift
//  MoonShot
//
//  Created by Alfonso Acosta on 2024-09-21.
//

import SwiftUI

/*
extension Bundle {
    func decode(_ file: String) -> [String: Astronaut]{
        guard let url = self.url(forResource: file, withExtension: nil) else { //when loading any life need to get url
            fatalError("no file")
        }
        guard let data = try? Data(contentsOf: url) else { //once we have the url we want to get whats inside it
            fatalError("no filed")
        }
        let decoder = JSONDecoder() //start decoding
        
        //to decode we need a Data type and something that confirms to Codable
        guard let loaded = try? decoder.decode([String: Astronaut].self, from: data) else {
            fatalError("no decode")
        }
        return loaded
    }
}

    */
//We can make use of swifts generics to make it work with any type


extension Bundle{
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else { //when loading any life need to get url
            fatalError("no file")
        }
        guard let data = try? Data(contentsOf: url) else { //once we have the url we want to get whats inside it
            fatalError("no filed")
        }
        let decoder = JSONDecoder() //start decoding
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter) // the decoder has a property called dateDecoingStrategy which determines how it should decode dates
        //to decode we need a Data type and something that confirms to Codable
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("no decode")
        }
        return loaded
    }
}

