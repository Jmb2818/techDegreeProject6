//
//  UserStrings.swift
//  SWAPI
//
//  Created by Joshua Borck on 2/4/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import Foundation

// Strings used throughout the app and mostly displayed to the user
class UserStrings {
    enum Error {
        static let okTitle = "Ok"
    }
    
    enum General {
        static let unknown = "unknown"
        static let characters = "Characters"
        static let vehicles = "Vehicles"
        static let starships = "Starships"
        static let meters = "m"
        static let english = "English"
        static let metric = "Metric"
        static let usd = "USD"
        static let credits = "Credits"
        static let one = "1"
        static let peopleURL = "https://swapi.co/api/people/"
        static let vehiclesURL = "https://swapi.co/api/vehicles/"
        static let starshipsURL = "https://swapi.co/api/starships/"
        static let planetsURL = "https://swapi.co/api/planets/"
    }
    
    enum Character {
        static let born = "Born"
        static let home = "Home"
        static let height = "Height"
        static let eyes = "Eyes"
        static let hair = "Hair"
    }
    
    enum Vehicle {
        static let make = "Make"
        static let cost = "Cost"
        static let length = "Length"
        static let vehicleClass = "Class"
        static let crew = "Crew"
    }
}
