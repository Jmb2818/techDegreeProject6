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
        guard let string = string, let number = Double(string) else {
            return UserStrings.General.unknown.capitalized
        }
        let meters = Measurement(value: number, unit: UnitLength.centimeters).converted(to: .meters).value
        return ["\(Formatter.formatToOneDecimal(meters))", "m"].joined()
    }
    
    static func formatToOneDecimal(_ number: Double, withUnit unit: String? = nil) -> String {
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .halfUp
        numberFormatter.maximumFractionDigits = 1
        
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
        guard let numberAsInt = Int(number) else {
            return UserStrings.General.unknown.capitalized
        }
        
        let nsNumber = NSNumber(value: numberAsInt)
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
}
