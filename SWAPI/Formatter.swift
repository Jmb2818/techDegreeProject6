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
    
    static func formatMetersFromString(string: String?) -> String? {
        guard let string = string, let number = Double(string) else {
            return "Unknown"
        }
        let meters = Measurement(value: number, unit: UnitLength.centimeters).converted(to: .meters).value
        return ["\(Formatter.formatToOneDeimal(meters))", "m"].joined()
    }
    
    static func formatToOneDeimal(_ number: Double) -> String {
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .halfUp
        numberFormatter.maximumFractionDigits = 1
        
        if let newNumberString = numberFormatter.string(from: NSNumber(value: number)) {
           return newNumberString
        }
       
        return "Unknown"
    }
    
    static func formatNumberWithComma(_ number: String) -> String {
        guard let numberAsInt = Int(number) else {
            return "Unknown"
        }
        
        let nsNumber = NSNumber(value: numberAsInt)
        numberFormatter.numberStyle = .decimal
        
        if let newNumberString = numberFormatter.string(from: nsNumber) {
            return newNumberString
        }
        
        return "Unknown"
    }
}
