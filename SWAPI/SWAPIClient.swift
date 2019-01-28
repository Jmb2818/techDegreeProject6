//
//  SWAPIClient.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/15/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import UIKit

class SWAPIClient {

    let decoder = JSONDecoder()
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    
    private func getCharacterResults(absoluteString: String?, completionHandler completion: @escaping (CharacterResults?, Error?) -> Void) {
        guard let urlString = absoluteString, let url = URL(string: urlString) else {
            completion(nil, SWAPIError.generic)
            return
        }
        
        let request = URLRequest(url: url)
        
        requestCodableObject(request: request, completionHandler: completion)
    }
    
    private func getVehicleResults(absoluteString: String?, completionHandler completion: @escaping (VehicleResults?, Error?) -> Void) {
        guard let urlString = absoluteString, let url = URL(string: urlString) else {
            completion(nil, SWAPIError.generic)
            return
        }
        
        let request = URLRequest(url: url)
        
        requestCodableObject(request: request, completionHandler: completion)
    }
    
    private func getStarshipResults(absoluteString: String?, completionHandler completion: @escaping (StarshipResults?, Error?) -> Void) {
        guard let urlString = absoluteString, let url = URL(string: urlString) else {
            completion(nil, SWAPIError.generic)
            return
        }
        
        let request = URLRequest(url: url)
        
        requestCodableObject(request: request, completionHandler: completion)
    }
    
    private func requestCodableObject<T: Codable>(request: URLRequest, completionHandler completion: @escaping (T?, Error?) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, SWAPIError.generic)
                        return
                    }
                    if httpResponse.statusCode == 200 {
                        do {
                            let results = try self.decoder.decode(T.self, from: data)
                            completion(results, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, SWAPIError.generic)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }

    
    var characters: [Character] = []
    var vehicles: [Vehicle] = []
    var starships: [Starship] = []
    
    
    func getCharacters(url: String?, completionHandler completion: @escaping ([Character]?, Error?) -> Void) {
        getCharacterResults(absoluteString: url) { [weak self] results, error in
            if self?.characters.count != results?.count, let _results = results {
                self?.characters.append(contentsOf: _results.results)
                self?.getCharacters(url: results?.next, completionHandler: completion)
            } else {
                completion(self?.characters, error)
            }
        }
    }
    
    func getVehicles(url: String?, completionHandler completion: @escaping ([Vehicle]?, Error?) -> Void) {
        getVehicleResults(absoluteString: url) { [weak self] results, error in
            if self?.vehicles.count != results?.count , let _results = results {
                self?.vehicles.append(contentsOf: _results.results)
                self?.getVehicles(url: results?.next, completionHandler: completion)
            } else {
                completion(self?.vehicles, error)
            }
        }
    }
   
    func getStarships(url: String?, completionHandler completion: @escaping ([Starship]?, Error?) -> Void) {
        getStarshipResults(absoluteString: url) { [weak self] results, error in
            if self?.starships.count != results?.count, let _results = results {
                self?.starships.append(contentsOf: _results.results)
                self?.getStarships(url: results?.next, completionHandler: completion)
            } else {
                completion(self?.starships, error)
            }
        }
    }
}
