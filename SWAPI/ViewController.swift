//
//  ViewController.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/1/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var characterButton: UIButton!
    @IBOutlet weak var vehicleButton: UIButton!

    @IBOutlet weak var starshipButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let client = SWAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        vehicleButton.isEnabled = true
        characterButton.isEnabled = true
        starshipButton.isEnabled = true
    }
    
    func load() {
        activityIndicator.startAnimating()
        vehicleButton.isEnabled = false
        characterButton.isEnabled = false
        starshipButton.isEnabled = false
    }
    
    func displayDetailView(results: [Result] = [], title: String, planets: [Planet]? = nil) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController {
            detailViewController.results = results
            detailViewController.planets = planets ?? []
            detailViewController.navigationItem.title = title
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }

    @IBAction func charactersSelected(_ sender: UIButton) {
        load()
        client.getCharacters(url: "https://swapi.co/api/people/") { [weak self] characters, error in
            if let characters = characters {
                self?.client.getPlanets(url: "https://swapi.co/api/planets/") { [weak self] planets, error in
                    if let planets = planets {
                        self?.activityIndicator.stopAnimating()
                        self?.displayDetailView(results: characters, title: "Characters", planets: planets)
                    }
                }
            }
        }
    }
    
    @IBAction func vehiclesSelected(_ sender: UIButton) {
        load()
        client.getVehicles(url: "https://swapi.co/api/vehicles/") { [weak self] vehicles, error in
            if let _vehicles = vehicles {
                
                self?.activityIndicator.stopAnimating()
                self?.displayDetailView(results: _vehicles, title: "Vehicles")
            }
        }

    }
    
    @IBAction func starshipsSelected(_ sender: UIButton) {
        load()
        client.getStarships(url: "https://swapi.co/api/starships/") { [weak self] starships, error in
            if let _starships = starships {
                
                self?.activityIndicator.stopAnimating()
                self?.displayDetailView(results: _starships, title: "Starships")
            }
        }
    }
    
}
