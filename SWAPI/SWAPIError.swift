//
//  SWAPIError.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/15/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import Foundation

enum SWAPIError: Error {
    case generic
    
    
    
    var errorMessages: String {
        switch self {
        case .generic:
            return "Sorry, an error has occured"
        }
    }
}
