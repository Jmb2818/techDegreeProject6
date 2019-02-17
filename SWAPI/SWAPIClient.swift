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
    
    
    func getCharacterResults(absoluteString: String?, completionHandler completion: @escaping (Page<Character>?, Error?) -> Void) {
        guard let urlString = absoluteString, let url = URL(string: urlString) else {
            completion(nil, SWAPIError.generic)
            return
        }
        
        let request = URLRequest(url: url)
        
        requestCodableObject(request: request, completionHandler: completion)
    }
    
    func getVehicleResults(absoluteString: String?, completionHandler completion: @escaping (Page<Vehicle>?, Error?) -> Void) {
        guard let urlString = absoluteString, let url = URL(string: urlString) else {
            completion(nil, SWAPIError.generic)
            return
        }
        
        let request = URLRequest(url: url)
        
        requestCodableObject(request: request, completionHandler: completion)
    }
    
    func getStarshipResults(absoluteString: String?, completionHandler completion: @escaping (Page<Starship>?, Error?) -> Void) {
        guard let urlString = absoluteString, let url = URL(string: urlString) else {
            completion(nil, SWAPIError.generic)
            return
        }
        
        let request = URLRequest(url: url)
        
        requestCodableObject(request: request, completionHandler: completion)
    }
    
    func getPlanetResults(absoluteString: String?, completionHandler completion: @escaping (Page<Planet>?, Error?) -> Void) {
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
}
