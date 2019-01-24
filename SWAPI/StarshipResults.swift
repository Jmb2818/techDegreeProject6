//
//  StarshipResults.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/19/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import Foundation

struct StarshipResults: Codable {
    var results: [Starship]
    let count: Int
    let next: String?
}
