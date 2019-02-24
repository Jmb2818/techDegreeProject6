//
//  Planet.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/22/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import Foundation

// Model for a planet that adheres to codable
struct Planet: Codable, Hashable {
    let name: String
    let url: String
}
