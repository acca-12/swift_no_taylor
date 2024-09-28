//
//  Colour-Theme.swift
//  MoonShot
//
//  Created by Alfonso Acosta on 2024-09-21.
//
import SwiftUI

extension ShapeStyle where Self == Color { //adding functionality to ShapeStyle, buit only for times when it's being used as a color
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }

    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}
