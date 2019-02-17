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
    
    let dataSource = StarWarsDataSource()
    
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
        guard !dataSource.hasCharacters && !dataSource.hasPlanets else {
            self.activityIndicator.stopAnimating()
            self.displayDetailView(results: self.dataSource.allCharacters, title: UserStrings.General.characters, planets: self.dataSource.allPlanets)
            return
        }
        dataSource.getCharacters(url: "https://swapi.co/api/people/") { [weak self] characters, error in
            if let characters = self?.dataSource.allCharacters {
                self?.dataSource.getPlanets(url: "https://swapi.co/api/planets/") { [weak self] planets, error in
                    if let planets = self?.dataSource.allPlanets {
                        self?.activityIndicator.stopAnimating()
                        self?.displayDetailView(results: characters, title: UserStrings.General.characters, planets: planets)
                    }
                }
            }
        }
    }
    
    @IBAction func vehiclesSelected(_ sender: UIButton) {
        load()
        guard !dataSource.hasVehicles else {
            self.activityIndicator.stopAnimating()
            self.displayDetailView(results: self.dataSource.allVehicles, title: UserStrings.General.vehicles)
            return
        }
        dataSource.getVehicles(url: "https://swapi.co/api/vehicles/") { [weak self] vehicles, error in
            if let vehicles = self?.dataSource.allVehicles {
                self?.activityIndicator.stopAnimating()
                self?.displayDetailView(results: vehicles, title: UserStrings.General.vehicles)
            }
        }

    }
    
    @IBAction func starshipsSelected(_ sender: UIButton) {
        load()
        guard !dataSource.hasStarships else {
            self.activityIndicator.stopAnimating()
            self.displayDetailView(results: self.dataSource.allCharacters, title: UserStrings.General.starships)
            return
        }
        dataSource.getStarships(url: "https://swapi.co/api/starships/") { [weak self] starships, error in
            if let starships = self?.dataSource.allStarships {
                self?.activityIndicator.stopAnimating()
                self?.displayDetailView(results: starships, title: UserStrings.General.starships)
            }
        }
    }
    
}
