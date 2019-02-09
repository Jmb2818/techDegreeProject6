//
//  InfoCell.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/14/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import UIKit
import Foundation

class InfoCell: UITableViewCell {
    
    // 1 credit = $4.075
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thirdLabel.isHidden = true
        fourthLabel.isHidden = true
        self.isUserInteractionEnabled = false
    }
    
    func configureCell(with result: Result, row: Int, nameLabel: UILabel, planets: [Planet]? = nil) {
        if let character = result as? Character {
            guard let planets = planets else {return}
            let planet = findHomeworld(character: character, planets: planets)
            configureCharacterCells(character: character, row: row, nameLabel: nameLabel, planet: planet)
        } else if let starship = result as? Starship {
            configureStarshipCells(starship: starship, row: row, nameLabel: nameLabel)
        } else if let vehicle = result as? Vehicle {
            configureVehicleCells(vehicle: vehicle, row: row, nameLabel: nameLabel)
        }
    }
    
    func findHomeworld(character: Character, planets: [Planet]) -> Planet? {
        for planet in planets {
            if planet.url == character.homeworld {
                return planet
            }
        }
        
        return nil
    }
    
    func configureMoney() {
        if thirdLabel.textColor == .white {
            fourthLabel.textColor = .white
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            let secondLabelWithoutDollar = self.secondLabel.text?.filter({ $0 != "$"})
            let secondLabel = secondLabelWithoutDollar?.filter( { $0 != ","})
            if let cost = secondLabel, let credits = Int(cost) {
                self.secondLabel.text = "\(credits/4)"
            }
        } else if fourthLabel.textColor == .white {
            thirdLabel.textColor = .white
            fourthLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            let secondLabel = self.secondLabel.text?.filter( { $0 != ","})
            if let cost = secondLabel, let credits = Int(cost) {
                 let costInDollarsString = String(credits * 4)
                self.secondLabel.text = "$\(Formatter.formatNumberWithComma(costInDollarsString))"
            }
        }
    }
    
    func configureLength() {
        if thirdLabel.textColor == .white {
            fourthLabel.textColor = .white
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            returnMetricUnits()
        } else if fourthLabel.textColor == .white {
            thirdLabel.textColor = .white
            fourthLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            returnImperialUnits()
        }
    }
    
    func returnMetricUnits() {
        let secondLabelNoN = self.secondLabel.text?.filter({ $0 != "n"})
        let secondLabelNoI = secondLabelNoN?.filter({ $0 != "i"})
        let secondLabel = secondLabelNoI?.filter( { $0 != ","})
        
        if let feet = secondLabel, let length = Double(feet) {
            let meters = Measurement(value: length, unit: UnitLength.inches).converted(to: .meters).value
            self.secondLabel.text = "\(Formatter.formatToOneDeimal(meters))m"
        }
    }
    
    func returnImperialUnits() {
        let secondLabelNoM = self.secondLabel.text?.filter({ $0 != "m"})
        let secondLabel = secondLabelNoM?.filter( { $0 != ","})
        if let meters = secondLabel, let length = Double(meters) {
            let feet = Measurement(value: length, unit: UnitLength.meters).converted(to: .inches).value
            self.secondLabel.text = "\(Formatter.formatToOneDeimal(feet))in"
        }
    }

    
    func configureCharacterCells(character: Character, row: Int, nameLabel: UILabel, planet: Planet?) {
        // TODO: Give the cell a model
        nameLabel.text = character.name
        switch row {
        case 0:
            self.firstLabel.text = "Born"
            self.secondLabel.text = character.birth_year.capitalized
        case 1:
            self.firstLabel.text = "Home"
            self.secondLabel.text = planet?.name.capitalized ?? "Unknown"
        case 2:
            self.isUserInteractionEnabled = true
            self.firstLabel.text = "Height"
            self.secondLabel.text = Formatter.formatMetersFromString(string: character.height)
            self.thirdLabel.isHidden = false
            self.thirdLabel.text = "English"
            self.fourthLabel.isHidden = false
            self.fourthLabel.text = "Metric"
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            self.fourthLabel.textColor = .white
        case 3:
            self.firstLabel.text = "Eyes"
            self.secondLabel.text = character.eye_color.capitalized
        case 4:
            self.firstLabel.text = "Hair"
            self.secondLabel.text = character.hair_color.capitalized
        default:
            break
        }
    }
    
    func configureStarshipCells(starship: Starship, row: Int, nameLabel: UILabel) {
        nameLabel.text = starship.name
        switch row {
        case 0:
            self.firstLabel.text = "Make"
            self.secondLabel.text = starship.manufacturer.capitalized
        case 1:
            self.isUserInteractionEnabled = true
            self.firstLabel.text = "Cost"
            self.secondLabel.text = Formatter.formatNumberWithComma(starship.cost_in_credits.capitalized)
            self.thirdLabel.isHidden = false
            self.thirdLabel.text = "USD"
            self.fourthLabel.isHidden = false
            self.fourthLabel.text = "Credits"
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            self.fourthLabel.textColor = .white
        case 2:
            self.isUserInteractionEnabled = true
            self.firstLabel.text = "Length"
            self.secondLabel.text = "\(starship.length)m"
            self.thirdLabel.isHidden = false
            self.thirdLabel.text = "English"
            self.fourthLabel.isHidden = false
            self.fourthLabel.text = "Metric"
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            self.fourthLabel.textColor = .white
        case 3:
            self.firstLabel.text = "Class"
            self.secondLabel.text = starship.starship_class.capitalized
        case 4:
            self.firstLabel.text = "Crew"
            self.secondLabel.text = starship.crew.capitalized
        default:
            break
        }
    }
    
    func configureVehicleCells(vehicle: Vehicle, row: Int, nameLabel: UILabel) {
        // TODO: Maybe use codable keys to rename vars so that you can be more generic with name, length, url
        nameLabel.text = vehicle.name
        switch row {
        case 0:
            firstLabel.text = "Make"
            secondLabel.text = vehicle.manufacturer.capitalized
        case 1:
            isUserInteractionEnabled = true
            firstLabel.text = "Cost"
            secondLabel.text = Formatter.formatNumberWithComma(vehicle.cost_in_credits.capitalized)
            thirdLabel.isHidden = false
            thirdLabel.text = "USD"
            fourthLabel.isHidden = false
            fourthLabel.text = "Credits"
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            fourthLabel.textColor = .white
        case 2:
            isUserInteractionEnabled = true
            firstLabel.text = "Length"
            secondLabel.text = "\(vehicle.length)m"
            thirdLabel.isHidden = false
            thirdLabel.text = "English"
            fourthLabel.isHidden = false
            fourthLabel.text = "Metric"
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            fourthLabel.textColor = .white
        case 3:
            firstLabel.text = "Class"
            secondLabel.text = vehicle.vehicle_class.capitalized
        case 4:
            firstLabel.text = "Crew"
            secondLabel.text = vehicle.crew
        default:
            break
        }
    }
}
