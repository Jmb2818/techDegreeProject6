//
//  InfoCellModel.swift
//  SWAPI
//
//  Created by Joshua Borck on 2/17/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import Foundation

typealias GeneralStrings = UserStrings.General
typealias CharacterStrings = UserStrings.Character
typealias VehicleStrings = UserStrings.Vehicle

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
            cellTitle = CharacterStrings.born
            cellData = character.birth_year.capitalizeBirthYear()
        case 1:
            cellTitle = CharacterStrings.home
            cellData = planet?.name.capitalized ?? GeneralStrings.unknown.capitalized
            needsConstraintUpdate = true
        case 2:
            shouldAllowInteraction = true
            cellTitle = CharacterStrings.height
            cellData = Formatter.formatMetersFromString(string: character.height)
            let cellDataUnknown = cellData == GeneralStrings.unknown.capitalized
            cellFirstSubLabel = cellDataUnknown ? nil : GeneralStrings.english
            cellSecondSubLabel = cellDataUnknown ? nil : GeneralStrings.metric
        case 3:
            cellTitle = CharacterStrings.eyes
            cellData = character.eye_color.capitalized
        case 4:
            cellTitle = CharacterStrings.hair
            cellData = character.hair_color.capitalized
        default:
            cellTitle = GeneralStrings.unknown.capitalized
            cellData = GeneralStrings.unknown.capitalized
        }
    }
    
    private init(starship: Starship, indexPath: IndexPath) {
        name = starship.name.capitalizeTitle()
        switch indexPath.row {
        case 0:
            cellTitle = VehicleStrings.make
            cellData = starship.manufacturer.capitalized
            needsConstraintUpdate = true
        case 1:
            shouldAllowInteraction = true
            cellTitle = VehicleStrings.cost
            cellData = Formatter.formatNumberWithComma(starship.cost_in_credits.capitalized)
            let cellDataUnknown = cellData == UserStrings.General.unknown.capitalized
            cellFirstSubLabel = cellDataUnknown ? nil : GeneralStrings.usd
            cellSecondSubLabel = cellDataUnknown ? nil : GeneralStrings.credits
        case 2:
            shouldAllowInteraction = true
            cellTitle = VehicleStrings.length
            cellData = "\(Formatter.formatNumberWithComma(starship.length, withUnit: GeneralStrings.meters))"
            let cellDataUnknown = cellData == UserStrings.General.unknown.capitalized
            cellFirstSubLabel = cellDataUnknown ? nil : GeneralStrings.english
            cellSecondSubLabel = cellDataUnknown ? nil : GeneralStrings.metric
        case 3:
            cellTitle = VehicleStrings.vehicleClass
            cellData = starship.starship_class.capitalized
            needsConstraintUpdate = true
        case 4:
            cellTitle = VehicleStrings.crew
            cellData = starship.crew.capitalized
        default:
            cellTitle = GeneralStrings.unknown.capitalized
            cellData = GeneralStrings.unknown.capitalized
        }
    }
    
    private init(vehicle: Vehicle, indexPath: IndexPath) {
        name = vehicle.name.capitalizeTitle()
        switch indexPath.row {
        case 0:
            cellTitle = VehicleStrings.make
            cellData = vehicle.manufacturer.capitalized
            needsConstraintUpdate = true
        case 1:
            shouldAllowInteraction = true
            cellTitle = VehicleStrings.cost
            cellData = Formatter.formatNumberWithComma(vehicle.cost_in_credits.capitalized)
            let cellDataUnknown = cellData == UserStrings.General.unknown.capitalized
            cellFirstSubLabel = cellDataUnknown ? nil : GeneralStrings.usd
            cellSecondSubLabel = cellDataUnknown ? nil : GeneralStrings.credits
        case 2:
            shouldAllowInteraction = true
            cellTitle = VehicleStrings.length
            cellData = "\(Formatter.formatNumberWithComma(vehicle.length, withUnit: GeneralStrings.meters))"
            let cellDataUnknown = cellData == UserStrings.General.unknown.capitalized
            cellFirstSubLabel = cellDataUnknown ? nil : GeneralStrings.english
            cellSecondSubLabel = cellDataUnknown ? nil : GeneralStrings.metric
        case 3:
            cellTitle = VehicleStrings.vehicleClass
            cellData = vehicle.vehicle_class.capitalized
            needsConstraintUpdate = true
        case 4:
            cellTitle = VehicleStrings.crew
            cellData = vehicle.crew.capitalized
        default:
            cellTitle = GeneralStrings.unknown.capitalized
            cellData = GeneralStrings.unknown.capitalized
        }
    }

    
}
