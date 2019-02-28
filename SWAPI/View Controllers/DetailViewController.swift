//
//  DetailViewController.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/13/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, NotificationPostable {
    
    // MARK: Properties
    var results: [StarWarsObject] = []
    var selectedResult: StarWarsObject?
    weak var database: StarWarsDataSource?
    
    // MARK: IBOutlets
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var smallestCharacter: UILabel!
    @IBOutlet weak var largestCharacter: UILabel!
    @IBOutlet weak var conversionTitle: UILabel!
    @IBOutlet weak var conversionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatNavigationBar()
        sortObjectsBySize(results: results)
        conversionTextField.text = GeneralStrings.one
    }
    
    private func formatNavigationBar() {
        // Format the navigation bar to match the mock
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1058823529, green: 0.1254901961, blue: 0.1411764706, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.5529411765, green: 0.5647058824, blue: 0.5725490196, alpha: 1)
    }
    
    func sortObjectsBySize(results: [StarWarsObject]) {
        // Sort results by size for the bottom view
        if let characterResults = results as? [Character] {
            let sortedCharacters = characterResults.sorted(by: { $0.heightAsInt > $1.heightAsInt })
            let sortedCharactersWithoutUnknown = sortedCharacters.filter { $0.heightAsInt != 0 }
            largestCharacter.text = sortedCharactersWithoutUnknown.first?.name
            smallestCharacter.text = sortedCharactersWithoutUnknown.last?.name
        } else if let vehicleResults = results as? [Vehicle] {
            let sortedVehicles = vehicleResults.sorted(by: { $0.lengthAsInt > $1.lengthAsInt })
            let sortedVehiclesWithoutUnknown = sortedVehicles.filter { $0.lengthAsInt != 0 }
            largestCharacter.text = sortedVehiclesWithoutUnknown.first?.name
            smallestCharacter.text = sortedVehiclesWithoutUnknown.last?.name
        } else if let starshipResults = results as? [Starship] {
            let sortedStarships = starshipResults.sorted(by: { $0.lengthAsInt > $1.lengthAsInt })
            let sortedStarshipsWithoutUnknown = sortedStarships.filter { $0.lengthAsInt != 0 }
            largestCharacter.text = sortedStarshipsWithoutUnknown.first?.name
            smallestCharacter.text = sortedStarshipsWithoutUnknown.last?.name
        }
    }
    
    func findHomeWorldIfPossible(result: StarWarsObject) -> Planet? {
        // Find the planet URL that matches the character home URL if possible to get planet name
        if let character = result as? Character {
            return database?.findHomeworld(character: character)
        }
        return nil
    }
}

// MARK: UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "infoTableViewCell", for: indexPath) as? InfoCell else { fatalError() }
        
        let tableViewHeight = tableView.bounds.height
        
        tableView.rowHeight = (tableViewHeight/5)
        
        if let result = selectedResult {
            let planet = findHomeWorldIfPossible(result: result)
            let model = InfoCellModel(result: result, indexPath: indexPath, planet: planet)
            nameLabel.text = model.name
            cell.configureCell(model: model)
        } else {
            let planet = findHomeWorldIfPossible(result: results[0])
            let model = InfoCellModel(result: results[0], indexPath: indexPath, planet: planet)
            nameLabel.text = model.name
            cell.configureCell(model: model)
        }
        if (!cell.thirdLabel.isHidden || !cell.fourthLabel.isHidden) && indexPath.row == 1 {
            conversionTitle.isHidden = false
            conversionTextField.isHidden = false
        }
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? InfoCell else { return }
        if indexPath.row == 1 {
           let conversionRate = checkConversionRate()
            cell.configureMoney(conversionRate: conversionRate)
        } else if indexPath.row == 2 {
            cell.configureLength()
        }
    }
    
    private func checkConversionRate() -> Double {
        let filteredConversionRateString = conversionTextField.text?.filter({ $0 != "," })
        guard let conversionRateString = filteredConversionRateString,
            let conversionRate = Double(conversionRateString),
            conversionRate > 0 else {
            presentAlert(from: self, title: SWAPIError.invalidConversionRate.errorTitle, message: SWAPIError.invalidConversionRate.errorMessages)
            return 1.0
        }
        
        return conversionRate
    }
}

// MARK: UIPickerViewDataSource
extension DetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return results.count
    }
}

// MARK: UIPickerViewDelegate
extension DetailViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return results[row].name.capitalizeTitle()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedResult = results[row]
        tableView.reloadData()
        conversionTitle.isHidden = true
        conversionTextField.isHidden = true
    }
}

// MARK: UITextFieldDelegate
extension DetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

