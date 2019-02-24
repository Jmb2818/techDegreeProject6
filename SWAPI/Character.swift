//
//  Character.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/15/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import Foundation

// Model for a character that adheres to codable
struct Character: StarWarsObject, Codable, Hashable {
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let homeworld: String
    
    var heightAsInt: Int {
        if let height = Int(self.height) {
            return height
        } else {
            return 0
        }
    }
}
