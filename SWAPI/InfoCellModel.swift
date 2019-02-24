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

// Model for the DetailViewController's TableViewCell
struct InfoCellModel {
    let name: String
    let cellTitle: String
    let cellData: String
    var cellFirstSubLabel: String? = nil
    var cellSecondSubLabel: String? = nil
    var needsConstraintUpdate: Bool = false
    var shouldAllowInteraction: Bool = false
    var shouldOnlyBeOneLine: Bool = false
    
    init(result: StarWarsObject, indexPath: IndexPath, planet: Planet? = nil) {
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
    
    // MARK: Formatting private init's for each category
    private init(character: Character, indexPath: IndexPath, planet: Planet? = nil) {
        name = character.name.capitalizeTitle()
        switch indexPath.row {
        case CellIndexFor.bornOrMake.rawValue:
            cellTitle = CharacterStrings.born
            cellData = character.birthYear.capitalizeBirthYear()
        case CellIndexFor.costOrHome.rawValue:
            cellTitle = CharacterStrings.home
            cellData = planet?.name.capitalized ?? GeneralStrings.unknown.capitalized
        case CellIndexFor.length.rawValue:
            shouldAllowInteraction = true
            shouldOnlyBeOneLine = true
            cellTitle = CharacterStrings.height
            cellData = Formatter.formatMetersFromString(string: character.height)
            let cellDataUnknown = cellData == GeneralStrings.unknown.capitalized
            cellFirstSubLabel = cellDataUnknown ? nil : GeneralStrings.english
            cellSecondSubLabel = cellDataUnknown ? nil : GeneralStrings.metric
        case CellIndexFor.classOrEyes.rawValue:
            cellTitle = CharacterStrings.eyes
            cellData = character.eyeColor.capitalized
        case CellIndexFor.crewOrHair.rawValue:
            cellTitle = CharacterStrings.hair
            cellData = character.hairColor.capitalized
        default:
            cellTitle = GeneralStrings.unknown.capitalized
            cellData = GeneralStrings.unknown.capitalized
        }
    }
    
    private init(starship: Starship, indexPath: IndexPath) {
        name = starship.name.capitalizeTitle()
        switch indexPath.row {
        case CellIndexFor.bornOrMake.rawValue:
            cellTitle = VehicleStrings.make
            cellData = starship.manufacturer.capitalized
            needsConstraintUpdate = true
        case CellIndexFor.costOrHome.rawValue:
            shouldAllowInteraction = true
            shouldOnlyBeOneLine = true
            cellTitle = VehicleStrings.cost
            cellData = Formatter.formatNumberWithComma(starship.cost.capitalized)
            let cellDataUnknown = cellData == UserStrings.General.unknown.capitalized
            cellFirstSubLabel = cellDataUnknown ? nil : GeneralStrings.usd
            cellSecondSubLabel = cellDataUnknown ? nil : GeneralStrings.credits
        case CellIndexFor.length.rawValue:
            shouldAllowInteraction = true
            shouldOnlyBeOneLine = true
            cellTitle = VehicleStrings.length
            cellData = "\(Formatter.formatNumberWithComma(starship.length, withUnit: GeneralStrings.meters))"
            let cellDataUnknown = cellData == UserStrings.General.unknown.capitalized
            cellFirstSubLabel = cellDataUnknown ? nil : GeneralStrings.english
            cellSecondSubLabel = cellDataUnknown ? nil : GeneralStrings.metric
        case CellIndexFor.classOrEyes.rawValue:
            cellTitle = VehicleStrings.vehicleClass
            cellData = starship.starshipClass.capitalized
            needsConstraintUpdate = true
        case CellIndexFor.crewOrHair.rawValue:
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
        case CellIndexFor.bornOrMake.rawValue:
            cellTitle = VehicleStrings.make
            cellData = vehicle.manufacturer.capitalized
            needsConstraintUpdate = true
        case CellIndexFor.costOrHome.rawValue:
            shouldAllowInteraction = true
            shouldOnlyBeOneLine = true
            cellTitle = VehicleStrings.cost
            cellData = Formatter.formatNumberWithComma(vehicle.cost.capitalized)
            let cellDataUnknown = cellData == UserStrings.General.unknown.capitalized
            cellFirstSubLabel = cellDataUnknown ? nil : GeneralStrings.usd
            cellSecondSubLabel = cellDataUnknown ? nil : GeneralStrings.credits
        case CellIndexFor.length.rawValue:
            shouldAllowInteraction = true
            shouldOnlyBeOneLine = true
            cellTitle = VehicleStrings.length
            cellData = "\(Formatter.formatNumberWithComma(vehicle.length, withUnit: GeneralStrings.meters))"
            let cellDataUnknown = cellData == UserStrings.General.unknown.capitalized
            cellFirstSubLabel = cellDataUnknown ? nil : GeneralStrings.english
            cellSecondSubLabel = cellDataUnknown ? nil : GeneralStrings.metric
        case CellIndexFor.classOrEyes.rawValue:
            cellTitle = VehicleStrings.vehicleClass
            cellData = vehicle.vehicleClass.capitalized
            needsConstraintUpdate = true
        case CellIndexFor.crewOrHair.rawValue:
            cellTitle = VehicleStrings.crew
            cellData = vehicle.crew.capitalized
        default:
            cellTitle = GeneralStrings.unknown.capitalized
            cellData = GeneralStrings.unknown.capitalized
        }
    }

    
}

enum CellIndexFor: Int {
    case bornOrMake = 0
    case costOrHome = 1
    case length = 2
    case classOrEyes = 3
    case crewOrHair = 4
}
