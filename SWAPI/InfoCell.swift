//
//  InfoCell.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/14/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        firstButton.isHidden = true
        secondButton.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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

    
    func configureCharacterCells(character: Character, row: Int, nameLabel: UILabel, planet: Planet?) {
        nameLabel.text = character.name
        switch row {
        case 0:
            self.firstLabel.text = "Born"
            self.secondLabel.text = character.birth_year.capitalized
        case 1:
            self.firstLabel.text = "Home"
            self.secondLabel.text = planet?.name ?? "Unknown"
        case 2:
            self.firstLabel.text = "Height"
            self.secondLabel.text = character.height.capitalized
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
            self.firstLabel.text = "Cost"
            self.secondLabel.text = starship.cost_in_credits.capitalized
        case 2:
            self.firstLabel.text = "Length"
            self.secondLabel.text = starship.length.capitalized
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
        nameLabel.text = vehicle.name
        switch row {
        case 0:
            self.firstLabel.text = "Make"
            self.secondLabel.text = vehicle.manufacturer.capitalized
        case 1:
            self.firstLabel.text = "Cost"
            self.secondLabel.text = vehicle.cost_in_credits.capitalized
        case 2:
            self.firstLabel.text = "Length"
            self.secondLabel.text = vehicle.length.capitalized
        case 3:
            self.firstLabel.text = "Class"
            self.secondLabel.text = vehicle.vehicle_class.capitalized
        case 4:
            self.firstLabel.text = "Crew"
            self.secondLabel.text = vehicle.crew
        default:
            break
        }
    }
    
    
}
