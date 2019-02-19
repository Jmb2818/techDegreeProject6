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
    
    
    var errorTitle: String {
        switch self {
        case .generic:
            return "Error"
        }
    }
    
    var errorMessages: String {
        switch self {
        case .generic:
            return "Sorry, something went wrong."
        }
    }
}
