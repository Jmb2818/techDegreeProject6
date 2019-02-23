//
//  ViewController.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/1/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NotificationPostable {

    @IBOutlet weak var characterButton: UIButton!
    @IBOutlet weak var vehicleButton: UIButton!

    @IBOutlet weak var collectionView: UICollectionView!
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
    
    func displayDetailView(results: [StarWarsObject] = [], title: String, planets: [Planet]? = nil) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController {
            detailViewController.results = results
            detailViewController.database = dataSource
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
        dataSource.getCharacters(url: "https://swapi.co/api/people/") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let characterResults):
                self.dataSource.getPlanets(url: "https://swapi.co/api/planets/") { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let planetResults):
                        self.activityIndicator.stopAnimating()
                        self.displayDetailView(results: Array(characterResults), title: UserStrings.General.characters, planets: Array(planetResults))
                    case .failure(let error):
                        if let swError = error as? SWAPIError {
                            self.presentAlert(from: self, title: swError.errorTitle, message: swError.errorMessages)
                        } else {
                            self.presentAlert(from: self, title: SWAPIError.generic.errorTitle, message: SWAPIError.generic.errorMessages)
                        }
                    }
                }
            case .failure(let error):
                if let swError = error as? SWAPIError {
                    self.presentAlert(from: self, title: swError.errorTitle, message: swError.errorMessages)
                } else {
                    self.presentAlert(from: self, title: SWAPIError.generic.errorTitle, message: SWAPIError.generic.errorMessages)
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
        dataSource.getVehicles(url: "https://swapi.co/api/vehicles/") { [weak self] result in
            switch result {
            case .success(let vehicleResults):
                self?.activityIndicator.stopAnimating()
                self?.displayDetailView(results: Array(vehicleResults), title: UserStrings.General.vehicles)
            case .failure(let error):
                print(error)
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
        dataSource.getStarships(url: "https://swapi.co/api/starships/") { [weak self] result in
            switch result {
            case .success(let starshipResults):
                self?.activityIndicator.stopAnimating()
                self?.displayDetailView(results: Array(starshipResults), title: UserStrings.General.starships)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCategoryCell", for: indexPath) as? MainCategoryCollectionViewCell else { fatalError() }
        
        cell.configure(for: indexPath)
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            load()
            guard !dataSource.hasCharacters && !dataSource.hasPlanets else {
                self.activityIndicator.stopAnimating()
                self.displayDetailView(results: self.dataSource.allCharacters, title: UserStrings.General.characters, planets: self.dataSource.allPlanets)
                return
            }
            dataSource.getCharacters(url: "https://swapi.co/api/people/") { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let characterResults):
                    self.dataSource.getPlanets(url: "https://swapi.co/api/planets/") { [weak self] result in
                        guard let self = self else { return }
                        switch result {
                        case .success(let planetResults):
                            self.activityIndicator.stopAnimating()
                            self.displayDetailView(results: Array(characterResults), title: UserStrings.General.characters, planets: Array(planetResults))
                        case .failure(let error):
                            if let swError = error as? SWAPIError {
                                self.presentAlert(from: self, title: swError.errorTitle, message: swError.errorMessages)
                            } else {
                                self.presentAlert(from: self, title: SWAPIError.generic.errorTitle, message: SWAPIError.generic.errorMessages)
                            }
                        }
                    }
                case .failure(let error):
                    if let swError = error as? SWAPIError {
                        self.presentAlert(from: self, title: swError.errorTitle, message: swError.errorMessages)
                    } else {
                        self.presentAlert(from: self, title: SWAPIError.generic.errorTitle, message: SWAPIError.generic.errorMessages)
                    }
                }
            }
        case 1:
            load()
            guard !dataSource.hasVehicles else {
                self.activityIndicator.stopAnimating()
                self.displayDetailView(results: self.dataSource.allVehicles, title: UserStrings.General.vehicles)
                return
            }
            dataSource.getVehicles(url: "https://swapi.co/api/vehicles/") { [weak self] result in
                switch result {
                case .success(let vehicleResults):
                    self?.activityIndicator.stopAnimating()
                    self?.displayDetailView(results: Array(vehicleResults), title: UserStrings.General.vehicles)
                case .failure(let error):
                    print(error)
                }
            }
        case 2:
            load()
            guard !dataSource.hasStarships else {
                self.activityIndicator.stopAnimating()
                self.displayDetailView(results: self.dataSource.allCharacters, title: UserStrings.General.starships)
                return
            }
            dataSource.getStarships(url: "https://swapi.co/api/starships/") { [weak self] result in
                switch result {
                case .success(let starshipResults):
                    self?.activityIndicator.stopAnimating()
                    self?.displayDetailView(results: Array(starshipResults), title: UserStrings.General.starships)
                case .failure(let error):
                    print(error)
                }
            }
        default:
            break
        }
    }
}
