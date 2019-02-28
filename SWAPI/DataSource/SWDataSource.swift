//
//  SWDataSource.swift
//  SWAPI
//
//  Created by Joshua Borck on 2/16/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import Foundation

// Class to hold data retrieved from the API
class StarWarsDataSource {
    
    // MARK: Properties
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
        let objectArray = Array(characters)
        let sortedObjectArray = objectArray.sorted(by: { $0.name < $1.name })
        return sortedObjectArray
    }
    
    var allVehicles: [Vehicle] {
        let objectArray = Array(vehicles)
        let sortedObjectArray = objectArray.sorted(by: { $0.name < $1.name })
        return sortedObjectArray
    }
    
    var allStarships: [Starship] {
        let objectArray = Array(starships)
        let sortedObjectArray = objectArray.sorted(by: { $0.name < $1.name })
        return sortedObjectArray
    }
    
    var allPlanets: [Planet] {
        let objectArray = Array(planets)
        let sortedObjectArray = objectArray.sorted(by: { $0.name < $1.name })
        return sortedObjectArray
    }
    
    // MARK: Helper Functions
    func getCharacters(url: String?, completionHandler completion: @escaping ResultCompletion<Set<Character>>) {
        // Get characters from the API
        client.getCharacterResults(absoluteString: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                _ = results.results.map({ self.characters.insert($0)})
                if self.characters.count != results.count {
                    self.getCharacters(url: results.next, completionHandler: completion)
                } else {
                    completion(.success(self.characters))
                }
            case .failure(let error):
                completion(.failure(error))
                if !self.characters.isEmpty {
                    self.characters.removeAll()
                }
            }
        }
    }
    
    func getVehicles(url: String?, completionHandler completion: @escaping ResultCompletion<Set<Vehicle>>) {
        // Get vehicles from the API
        client.getVehicleResults(absoluteString: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                _ = results.results.map({ self.vehicles.insert($0)})
                if self.vehicles.count != results.count {
                    self.getVehicles(url: results.next, completionHandler: completion)
                } else {
                    completion(.success(self.vehicles))
                }
            case .failure(let error):
                completion(.failure(error))
                if !self.vehicles.isEmpty {
                    self.vehicles.removeAll()
                }
            }
        }
    }
    
    func getStarships(url: String?, completionHandler completion: @escaping ResultCompletion<Set<Starship>>) {
        // Get starships from the API
        client.getStarshipResults(absoluteString: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                _ = results.results.map({ self.starships.insert($0)})
                if self.starships.count != results.count {
                    self.getStarships(url: results.next, completionHandler: completion)
                } else {
                    completion(.success(self.starships))
                }
            case .failure(let error):
                completion(.failure(error))
                if !self.starships.isEmpty {
                    self.starships.removeAll()
                }
            }
        }
    }
    
    func getPlanets(url: String?, completionHandler completion: @escaping ResultCompletion<Set<Planet>>) {
        // Get planets from the API
        client.getPlanetResults(absoluteString: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                _ = results.results.map({ self.planets.insert($0)})
                if self.planets.count != results.count {
                    self.getPlanets(url: results.next, completionHandler: completion)
                } else {
                    completion(.success(self.planets))
                }
            case .failure(let error):
                completion(.failure(error))
                if !self.planets.isEmpty {
                    self.planets.removeAll()
                }
            }
        }
    }
    
    func findHomeworld(character: Character) -> Planet? {
        // Find homeworld from the character's homeworld
        for planet in self.planets {
            if planet.url == character.homeworld {
                return planet
            }
        }
        
        return nil
    }
}
