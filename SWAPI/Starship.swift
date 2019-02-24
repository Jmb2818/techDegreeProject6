//
//  Starship.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/19/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import Foundation

// Model for a starship that adheres to codable
struct Starship: StarWarsObject, Codable, Hashable {
    let name: String
    let manufacturer: String
    let cost_in_credits: String
    let length: String
    let starship_class: String
    let crew: String
    
    var lengthAsInt: Int {
        if let length = Int(self.length) {
            return length
        } else {
            return 0
        }
    }
}
