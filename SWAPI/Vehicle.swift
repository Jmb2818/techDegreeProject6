//
//  Vehicle.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/19/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import Foundation

// Model for a vehicle that adheres to codable
struct Vehicle: StarWarsObject, Codable, Hashable {
    let name: String
    let manufacturer: String
    let cost: String
    let length: String
    let vehicleClass: String
    let crew: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case manufacturer
        case cost = "cost_in_credits"
        case length
        case vehicleClass = "vehicle_class"
        case crew
    }
    
    var lengthAsInt: Int {
        if let length = Int(self.length) {
            return length
        } else {
            return 0
        }
    }
}
