//
//  Formatter.swift
//  SWAPI
//
//  Created by Joshua Borck on 2/3/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import Foundation

class Formatter {
    
    static var numberFormatter = NumberFormatter()
    
    static func formatMetersFromString(string: String?) -> String {
        // Take a string if there is one that can be a double and return it formatted for meters
        guard let string = string, let number = Double(string) else {
            return UserStrings.General.unknown.capitalized
        }
        let meters = Measurement(value: number, unit: UnitLength.centimeters).converted(to: .meters).value
        return Formatter.formatNumberDecimalPlacesTo(1, number: meters, withUnit: "m")
    }
    
    static func formatNumberDecimalPlacesTo(_ decimalPlaces: Int, number: Double, withUnit unit: String? = nil) -> String {
        // Takes a double and formats it to only one decimal place and returns it as a string with a unit
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .halfUp
        numberFormatter.maximumFractionDigits = decimalPlaces
        
        if let newNumberString = numberFormatter.string(from: NSNumber(value: number)) {
            if let unit = unit {
                return [newNumberString, unit].joined()
            } else {
                return newNumberString
            }
        }
       
        return UserStrings.General.unknown.capitalized
    }
    
    static func formatNumberWithComma(_ number: String, withUnit unit: String? = nil) -> String {
        // Takes a number as a string and formats it properly with a comma
        guard let numberAsDouble = Double(number) else {
            return UserStrings.General.unknown.capitalized
        }
        
        let nsNumber = NSNumber(value: numberAsDouble)
        numberFormatter.numberStyle = .decimal
        
        if let newNumberString = numberFormatter.string(from: nsNumber) {
            if let unit = unit {
                return [newNumberString, unit].joined()
            } else {
                return newNumberString
            }
        }
        
        return UserStrings.General.unknown.capitalized
    }
    
    static func convertToMetricUnits(secondLabelText: String?) -> String? {
        // Takes a string and removes all uneccesary extras and converts it from inches to meters
        let secondLabelNoComma = secondLabelText?.filter({ $0 != "," })
        let secondLabel = secondLabelNoComma?.filter( { !($0 == "i" ||  $0 == "n") })
        
        if let feet = secondLabel, let length = Double(feet) {
            let meters = Measurement(value: length, unit: UnitLength.inches).converted(to: .meters).value
            return Formatter.formatNumberDecimalPlacesTo(1, number: meters, withUnit: "m")
        }
        return nil
    }
    
    static func convertToImperialUnits(secondLabelText: String?) -> String? {
        // Takes a string and removes all uneccesary extras and converts it from meters to inches
        let secondLabel = secondLabelText?.filter( { !($0 == "," || $0 == "m") })
        
        if let meters = secondLabel, let length = Double(meters) {
            let feet = Measurement(value: length, unit: UnitLength.meters).converted(to: .inches).value
            return Formatter.formatNumberDecimalPlacesTo(1, number: feet, withUnit: "in")
        }
        return nil
    }
    
    static func convertToUSD(secondLabelText: String?, conversionRate: Double) -> String? {
        // Takes a string and removes all uneccesary extras and converts it from credits to USD
        let secondLabel = secondLabelText?.filter( { $0 != ","})
        if let cost = secondLabel, let dollars = Double(cost) {
            let costInDollarsString = Formatter.formatNumberDecimalPlacesTo(2, number: (dollars * conversionRate))
            return "$\(costInDollarsString)"
        }
        return nil
    }
    
    static func convertToCredits(secondLabelText: String?, conversionRate: Double) -> String? {
        // Takes a string and removes all uneccesary extras and converts it from USD to credits
        let secondLabel = secondLabelText?.filter( { !($0 == "," || $0 == "$") })
        if let cost = secondLabel, let credits = Double(cost) {
            let costInCreditsString = Formatter.formatNumberDecimalPlacesTo(2, number: (credits/conversionRate))
            return costInCreditsString
        }
        return nil
    }
}
