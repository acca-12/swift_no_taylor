//
//  Prospect.swift
//  Hot Prospects
//
//  Created by Alfonso Acosta on 2024-09-24.
//

import Foundation

import SwiftData

@Model //data persistence
class Prospect{
    var name: String
    var emailAddress: String
    var isContacted: Bool
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}
