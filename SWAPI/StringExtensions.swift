//
//  StringExtensions.swift
//  SWAPI
//
//  Created by Joshua Borck on 2/10/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import UIKit

extension String {
    
    func capitalizeBirthYear() -> String {
        // Capitalize the specific birth year format from the API
        if self == UserStrings.General.unknown {
            return UserStrings.General.unknown.capitalized
        }
        
        return self.uppercased()
    }
    
    func capitalizeTitle() -> String {
        // Capitalize the name of object format correctly from the API
        var shouldCapitalizeNextElement: Bool = false
        var characters: [String] = []
        guard self != UserStrings.General.unknown else {
            return UserStrings.General.unknown.capitalized
        }
        
        for character in self {
            if character == " " || character == "-" {
                shouldCapitalizeNextElement = true
                characters.append(String(character))
                continue
            }
            if shouldCapitalizeNextElement {
                let string = String(character).uppercased()
                characters.append(string)
                shouldCapitalizeNextElement = false
                continue
            }
            characters.append(String(character))
        }
        return characters.joined()
    }
}
