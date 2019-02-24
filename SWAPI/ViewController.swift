//
//  ViewController.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/1/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NotificationPostable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let dataSource = StarWarsDataSource()
    private var categoryCount: Int = 3
    private let loadingIndicator = UIActivityIndicatorView(style: .whiteLarge)
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBlurView()
        view.addSubview(loadingIndicator)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.center = view.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        collectionView.isUserInteractionEnabled = true
    }
    
    private func load() {
        blurView.isHidden = false
        loadingIndicator.startAnimating()
        collectionView.isUserInteractionEnabled = false
    }
    
    private func addBlurView() {
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurView)
        blurView.isHidden = true
    }
    private func reset() {
        blurView.isHidden = true
        collectionView.isUserInteractionEnabled = true
    }
    
    private func displayDetailView(results: [StarWarsObject] = [], title: String, planets: [Planet]? = nil) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController {
            detailViewController.results = results
            detailViewController.database = dataSource
            detailViewController.navigationItem.title = title
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    private func fetchCharacters () {
        guard !dataSource.hasCharacters && !dataSource.hasPlanets else {
            self.loadingIndicator.stopAnimating()
            self.displayDetailView(results: self.dataSource.allCharacters, title: UserStrings.General.characters, planets: self.dataSource.allPlanets)
            blurView.isHidden = true
            return
        }
        dataSource.getCharacters(url: UserStrings.General.peopleURL) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let characterResults):
                self.dataSource.getPlanets(url: UserStrings.General.planetsURL) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let planetResults):
                        self.loadingIndicator.stopAnimating()
                        self.displayDetailView(results: Array(characterResults).sorted(by: { $0.name < $1.name }),
                                               title: UserStrings.General.characters,
                                               planets: Array(planetResults).sorted(by: { $0.name < $1.name }))
                        self.blurView.isHidden = true
                    case .failure(let error):
                        let swError = (error as? SWAPIError) ?? SWAPIError.generic
                        self.presentAlert(from: self, title: swError.errorTitle, message: swError.errorMessages)
                    }
                }
            case .failure(let error):
                let swError = (error as? SWAPIError) ?? SWAPIError.generic
                self.presentAlert(from: self, title: swError.errorTitle, message: swError.errorMessages)
                self.reset()
            }
        }
    }
    
    private func fetchVehicles() {
        guard !dataSource.hasVehicles else {
            self.loadingIndicator.stopAnimating()
            self.displayDetailView(results: self.dataSource.allVehicles, title: UserStrings.General.vehicles)
            blurView.isHidden = true
            return
        }
        dataSource.getVehicles(url: UserStrings.General.vehiclesURL) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let vehicleResults):
                self.loadingIndicator.stopAnimating()
                self.displayDetailView(results: Array(vehicleResults).sorted(by: { $0.name < $1.name }), title: UserStrings.General.vehicles)
                self.blurView.isHidden = true
            case .failure(let error):
                let swError = (error as? SWAPIError) ?? SWAPIError.generic
                self.presentAlert(from: self, title: swError.errorTitle, message: swError.errorMessages)
                self.reset()
            }
        }
    }
    
    private func fetchStarchips() {
        guard !dataSource.hasStarships else {
            self.loadingIndicator.stopAnimating()
            self.displayDetailView(results: self.dataSource.allStarships, title: UserStrings.General.starships)
            blurView.isHidden = true
            return
        }
        dataSource.getStarships(url: UserStrings.General.starshipsURL) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let starshipResults):
                self.loadingIndicator.stopAnimating()
                self.displayDetailView(results: Array(starshipResults).sorted(by: { $0.name < $1.name }), title: UserStrings.General.starships)
                self.blurView.isHidden = true
            case .failure(let error):
                let swError = (error as? SWAPIError) ?? SWAPIError.generic
                self.presentAlert(from: self, title: swError.errorTitle, message: swError.errorMessages)
                self.reset()
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let containerSize = collectionView.frame.size
        let height = containerSize.height/CGFloat(categoryCount)
        return CGSize(width: containerSize.width, height: height)
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
        load()
        switch indexPath.item {
        case 0:
            fetchCharacters()
        case 1:
            fetchVehicles()
        case 2:
            fetchStarchips()
        default:
            break
        }
    }
}
