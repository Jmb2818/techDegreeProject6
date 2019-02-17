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
    
    func configureMoney(conversionRate: Int) {
        guard conversionRate > 0 else {
            //TODO: Throw conversion rate incorrect error
            return
        }
        if thirdLabel.textColor == .white {
            fourthLabel.textColor = .white
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            let secondLabelWithoutDollar = self.secondLabel.text?.filter({ $0 != "$"})
            let secondLabel = secondLabelWithoutDollar?.filter( { $0 != ","})
            if let cost = secondLabel, let credits = Int(cost) {
                let costInCreditsString = String(credits/conversionRate)
                self.secondLabel.text = "\(Formatter.formatNumberWithComma(costInCreditsString))"
            }
        } else if fourthLabel.textColor == .white {
            thirdLabel.textColor = .white
            fourthLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            let secondLabel = self.secondLabel.text?.filter( { $0 != ","})
            if let cost = secondLabel, let credits = Int(cost) {
                let costInDollarsString = String(credits * conversionRate)
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
            self.secondLabel.text = "\(Formatter.formatToOneDecimal(meters))m"
        }
    }
    
    func returnImperialUnits() {
        let secondLabelNoM = self.secondLabel.text?.filter({ $0 != "m"})
        let secondLabel = secondLabelNoM?.filter( { $0 != ","})
        if let meters = secondLabel, let length = Double(meters) {
            let feet = Measurement(value: length, unit: UnitLength.meters).converted(to: .inches).value
            self.secondLabel.text = "\(Formatter.formatToOneDecimal(feet))in"
        }
    }

    
    func configureCharacterCells(character: Character, row: Int, nameLabel: UILabel, planet: Planet?) {
        // TODO: Give the cell a model and have it init with each number but name the variables the same
        // so firstLabel.text = model.name, firstLabel.text = model.firstCellLabel
        nameLabel.text = character.name.capitalizeTitle()
        switch row {
        case 0:
            firstLabel.text = "Born"
            secondLabel.text = character.birth_year.capitalizeBirthYear()
        case 1:
            firstLabel.text = "Home"
            updateConstraintForFullTitle()
            secondLabel.text = planet?.name.capitalized ?? "Unknown"
        case 2:
            isUserInteractionEnabled = true
            firstLabel.text = "Height"
            secondLabel.text = Formatter.formatMetersFromString(string: character.height)
            thirdLabel.isHidden = secondLabel.text != "Unknown" ? false : true
            thirdLabel.text = "English"
            fourthLabel.isHidden = secondLabel.text != "Unknown" ? false : true
            fourthLabel.text = "Metric"
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            fourthLabel.textColor = .white
        case 3:
            firstLabel.text = "Eyes"
            secondLabel.text = character.eye_color.capitalized
        case 4:
            firstLabel.text = "Hair"
            secondLabel.text = character.hair_color.capitalized
        default:
            break
        }
    }
    
    func configureStarshipCells(starship: Starship, row: Int, nameLabel: UILabel) {
        nameLabel.text = starship.name.capitalizeTitle()
        switch row {
        case 0:
            firstLabel.text = "Make"
            updateConstraintForFullTitle()
            secondLabel.text = starship.manufacturer.capitalized
        case 1:
            isUserInteractionEnabled = true
            firstLabel.text = "Cost"
            secondLabel.numberOfLines = 1
            secondLabel.text = Formatter.formatNumberWithComma(starship.cost_in_credits.capitalized)
            thirdLabel.isHidden = secondLabel.text != "Unknown" ? false : true
            thirdLabel.text = "USD"
            fourthLabel.isHidden = secondLabel.text != "Unknown" ? false : true
            fourthLabel.text = "Credits"
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            fourthLabel.textColor = .white
        case 2:
            isUserInteractionEnabled = true
            firstLabel.text = "Length"
            secondLabel.text = "\(Formatter.formatNumberWithComma(starship.length, withUnit: "m"))"
            thirdLabel.isHidden = secondLabel.text != "Unknown" ? false : true
            thirdLabel.text = "English"
            fourthLabel.isHidden = secondLabel.text != "Unknown" ? false : true
            fourthLabel.text = "Metric"
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            fourthLabel.textColor = .white
        case 3:
            firstLabel.text = "Class"
            updateConstraintForFullTitle()
            secondLabel.text = starship.starship_class.capitalized
        case 4:
            firstLabel.text = "Crew"
            secondLabel.text = starship.crew.capitalized
        default:
            break
        }
    }
    
    func configureVehicleCells(vehicle: Vehicle, row: Int, nameLabel: UILabel) {
        // TODO: Maybe use codable keys to rename vars so that you can be more generic with name, length, url
        nameLabel.text = vehicle.name.capitalizeTitle()
        switch row {
        case 0:
            firstLabel.text = "Make"
            updateConstraintForFullTitle()
            secondLabel.text = vehicle.manufacturer.capitalized
        case 1:
            isUserInteractionEnabled = true
            firstLabel.text = "Cost"
            secondLabel.numberOfLines = 1
            secondLabel.text = Formatter.formatNumberWithComma(vehicle.cost_in_credits.capitalized)
            thirdLabel.isHidden = secondLabel.text != "Unknown" ? false : true
            thirdLabel.text = "USD"
            fourthLabel.isHidden = secondLabel.text != "Unknown" ? false : true
            fourthLabel.text = "Credits"
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            fourthLabel.textColor = .white
        case 2:
            isUserInteractionEnabled = true
            firstLabel.text = "Length"
            secondLabel.text = "\(Formatter.formatNumberWithComma(vehicle.length, withUnit: "m"))"
            thirdLabel.isHidden = secondLabel.text != "Unknown" ? false : true
            thirdLabel.text = "English"
            fourthLabel.isHidden = secondLabel.text != "Unknown" ? false : true
            fourthLabel.text = "Metric"
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            fourthLabel.textColor = .white
        case 3:
            firstLabel.text = "Class"
            updateConstraintForFullTitle()
            secondLabel.text = vehicle.vehicle_class.capitalized
        case 4:
            firstLabel.text = "Crew"
            secondLabel.text = vehicle.crew
        default:
            break
        }
    }
    
    func updateConstraintForFullTitle() {
        secondLabel.trailingAnchor.constraint(equalTo: fourthLabel.trailingAnchor, constant: 0).isActive = true
    }
}
