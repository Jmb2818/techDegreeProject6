//
//  InfoCellModel.swift
//  SWAPI
//
//  Created by Joshua Borck on 2/17/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import Foundation

struct InfoCellModel {
    let name: String
    let cellTitle: String
    let cellData: String
    var cellFirstSubLabel: String? = nil
    var cellSecondSubLabel: String? = nil
    var needsConstraintUpdate: Bool = false
    var shouldAllowInteraction: Bool = false
    
    init(result: Result, indexPath: IndexPath, planet: Planet? = nil) {
        if let character = result as? Character {
            self.init(character: character, indexPath: indexPath, planet: planet)
        } else if let starship = result as? Starship {
            self.init(starship: starship, indexPath: indexPath)
        } else if let vehicle = result as? Vehicle {
            self.init(vehicle: vehicle, indexPath: indexPath)
        } else {
            fatalError()
        }
    }
    
    private init(character: Character, indexPath: IndexPath, planet: Planet? = nil) {
        name = character.name.capitalizeTitle()
        switch indexPath.row {
        case 0:
            cellTitle = "Born"
            cellData = character.birth_year.capitalizeBirthYear()
        case 1:
            cellTitle = "Home"
            cellData = planet?.name.capitalized ?? UserStrings.General.unknown.capitalized
            needsConstraintUpdate = true
        case 2:
            shouldAllowInteraction = true
            cellTitle = "Height"
            cellData = Formatter.formatMetersFromString(string: character.height)
            let cellDataUnknown = cellData == UserStrings.General.unknown.capitalized
            cellFirstSubLabel = cellDataUnknown ? nil : "English"
            cellSecondSubLabel = cellDataUnknown ? nil : "Metric"
        case 3:
            cellTitle = "Eyes"
            cellData = character.eye_color.capitalized
        case 4:
            cellTitle = "Hair"
            cellData = character.hair_color.capitalized
        default:
            cellTitle = "Unknown"
            cellData = "Unknown"
        }
    }
    
    private init(starship: Starship, indexPath: IndexPath) {
        name = starship.name.capitalizeTitle()
        switch indexPath.row {
        case 0:
            cellTitle = "Make"
            cellData = starship.manufacturer.capitalized
            needsConstraintUpdate = true
        case 1:
            shouldAllowInteraction = true
            cellTitle = "Cost"
            cellData = Formatter.formatNumberWithComma(starship.cost_in_credits.capitalized)
            let cellDataUnknown = cellData == UserStrings.General.unknown.capitalized
            cellFirstSubLabel = cellDataUnknown ? nil : "USD"
            cellSecondSubLabel = cellDataUnknown ? nil : "Credits"
        case 2:
            shouldAllowInteraction = true
            cellTitle = "Length"
            cellData = "\(Formatter.formatNumberWithComma(starship.length, withUnit: "m"))"
            let cellDataUnknown = cellData == UserStrings.General.unknown.capitalized
            cellFirstSubLabel = cellDataUnknown ? nil : "English"
            cellSecondSubLabel = cellDataUnknown ? nil : "Metric"
        case 3:
            cellTitle = "Class"
            cellData = starship.starship_class.capitalized
            needsConstraintUpdate = true
        case 4:
            cellTitle = "Crew"
            cellData = starship.crew.capitalized
        default:
            cellTitle = "Unknown"
            cellData = "Unknown"
        }
    }
    
    private init(vehicle: Vehicle, indexPath: IndexPath) {
        name = vehicle.name.capitalizeTitle()
        switch indexPath.row {
        case 0:
            cellTitle = "Make"
            cellData = vehicle.manufacturer.capitalized
            needsConstraintUpdate = true
        case 1:
            shouldAllowInteraction = true
            cellTitle = "Cost"
            cellData = Formatter.formatNumberWithComma(vehicle.cost_in_credits.capitalized)
            let cellDataUnknown = cellData == UserStrings.General.unknown.capitalized
            cellFirstSubLabel = cellDataUnknown ? nil : "USD"
            cellSecondSubLabel = cellDataUnknown ? nil : "Credits"
        case 2:
            shouldAllowInteraction = true
            cellTitle = "Length"
            cellData = "\(Formatter.formatNumberWithComma(vehicle.length, withUnit: "m"))"
            let cellDataUnknown = cellData == UserStrings.General.unknown.capitalized
            cellFirstSubLabel = cellDataUnknown ? nil : "English"
            cellSecondSubLabel = cellDataUnknown ? nil : "Metric"
        case 3:
            cellTitle = "Class"
            cellData = vehicle.vehicle_class.capitalized
            needsConstraintUpdate = true
        case 4:
            cellTitle = "Crew"
            cellData = vehicle.crew.capitalized
        default:
            cellTitle = "Unknown"
            cellData = "Unknown"
        }
    }

    
}
