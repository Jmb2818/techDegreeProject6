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
    
    
    func getCharacters(url: String?, completionHandler completion: @escaping ResultCompletion<Set<Character>>) {
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
            }
        }
    }
    
    func getVehicles(url: String?, completionHandler completion: @escaping ResultCompletion<Set<Vehicle>>) {
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
            }
        }
    }
    
    func getStarships(url: String?, completionHandler completion: @escaping ResultCompletion<Set<Starship>>) {
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
            }
        }
    }
    
    func getPlanets(url: String?, completionHandler completion: @escaping ResultCompletion<Set<Planet>>) {
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
            }
        }
    }
    
    func findHomeworld(character: Character) -> Planet? {
        for planet in self.planets {
            if planet.url == character.homeworld {
                return planet
            }
        }
        
        return nil
    }
}
