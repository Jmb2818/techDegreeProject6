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
    
    func getCharacterResults(absoluteString: String?, completionHandler completion: @escaping ResultCompletion<Page<Character>>) {
        // Wrapper function to do generic request with the correct url
        guard let urlString = absoluteString, let url = URL(string: urlString) else {
            completion(.failure(SWAPIError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        requestCodableObject(request: request, completionHandler: completion)
    }
    
    func getVehicleResults(absoluteString: String?, completionHandler completion: @escaping ResultCompletion<Page<Vehicle>>) {
        // Wrapper function to do generic request with the correct url
        guard let urlString = absoluteString, let url = URL(string: urlString) else {
            completion(.failure(SWAPIError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        requestCodableObject(request: request, completionHandler: completion)
    }
    
    func getStarshipResults(absoluteString: String?, completionHandler completion: @escaping ResultCompletion<Page<Starship>>) {
        // Wrapper function to do generic request with the correct url
        guard let urlString = absoluteString, let url = URL(string: urlString) else {
            completion(.failure(SWAPIError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        requestCodableObject(request: request, completionHandler: completion)
    }
    
    func getPlanetResults(absoluteString: String?, completionHandler completion: @escaping ResultCompletion<Page<Planet>>) {
        guard let urlString = absoluteString, let url = URL(string: urlString) else {
            completion(.failure(SWAPIError.generic))
            return
        }
        
        let request = URLRequest(url: url)
        
        requestCodableObject(request: request, completionHandler: completion)
    }
    
    private func requestCodableObject<T: Codable>(request: URLRequest, completionHandler completion: @escaping ResultCompletion<T>) {
        // Main generic function that makes the request and returns codable object
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(.failure(SWAPIError.invalidHTTPResponse))
                        return
                    }
                    if httpResponse.statusCode == 200 {
                        do {
                            let results = try self.decoder.decode(T.self, from: data)
                            completion(.success(results))
                        } catch {
                            completion(.failure(SWAPIError.unableToParse))
                        }
                    } else {
                        completion(.failure(SWAPIError.invalidStatusCode(httpResponse.statusCode)))
                    }
                } else {
                    completion(.failure(SWAPIError.unableToRetrieveData))
                }
            }
        }
        task.resume()
    }
}
