//
//  SWDataSource.swift
//  SWAPI
//
//  Created by Joshua Borck on 2/16/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import Foundation

class StarWarsDataSource {
    

    private var characters = Set<Character>()
    private var vehicles = Set<Vehicle>()
    private var starships = Set<Starship>()
    private var planets = Set<Planet>()
    private var client = SWAPIClient()
    
    var hasCharacters: Bool {
        return !characters.isEmpty
    }
    
    var hasVehicles: Bool {
        return !vehicles.isEmpty
    }
    
    var hasStarships: Bool {
        return !starships.isEmpty
    }
    
    var hasPlanets: Bool {
        return !planets.isEmpty
    }
    
    var allCharacters: [Character] {
        return Array(characters)
    }
    
    var allVehicles: [Vehicle] {
        return Array(vehicles)
    }
    
    var allStarships: [Starship] {
        return Array(starships)
    }
    
    var allPlanets: [Planet] {
        return Array(planets)
    }
    
    
    func getCharacters(url: String?, completionHandler completion: @escaping (Set<Character>?, Error?) -> Void) {
        client.getCharacterResults(absoluteString: url) { [weak self] results, error in
            if self?.characters.count != results?.count, let _results = results {
                _ = _results.results.map({ self?.characters.insert($0)})
                self?.getCharacters(url: results?.next, completionHandler: completion)
            } else {
                completion(self?.characters, error)
            }
        }
    }
    
    func getVehicles(url: String?, completionHandler completion: @escaping (Set<Vehicle>?, Error?) -> Void) {
        client.getVehicleResults(absoluteString: url) { [weak self] results, error in
            if self?.vehicles.count != results?.count , let _results = results {
                _ = _results.results.map({ self?.vehicles.insert($0)})
                self?.getVehicles(url: results?.next, completionHandler: completion)
            } else {
                completion(self?.vehicles, error)
            }
        }
    }
    
    func getStarships(url: String?, completionHandler completion: @escaping (Set<Starship>?, Error?) -> Void) {
        client.getStarshipResults(absoluteString: url) { [weak self] results, error in
            if self?.starships.count != results?.count, let _results = results {
                _ = _results.results.map({ self?.starships.insert($0)})
                self?.getStarships(url: results?.next, completionHandler: completion)
            } else {
                completion(self?.starships, error)
            }
        }
    }
    
    func getPlanets(url: String?, completionHandler completion: @escaping (Set<Planet>?, Error?) -> Void) {
        client.getPlanetResults(absoluteString: url) { [weak self] results, error in
            if self?.planets.count != results?.count, let _results = results {
                _ = _results.results.map({ self?.planets.insert($0)})
                self?.getPlanets(url: results?.next, completionHandler: completion)
            } else {
                completion(self?.planets, error)
            }
        }
    }
}
