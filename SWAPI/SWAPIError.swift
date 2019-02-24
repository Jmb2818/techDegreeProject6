//
//  SWAPIError.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/15/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import Foundation

// Error enum for all the errors thrown in the app
enum SWAPIError: Error {
    case generic
    case unableToParse
    case invalidConversionRate
    case invalidHTTPResponse
    case invalidStatusCode(Int)
    case unableToRetrieveData
    case invalidURL
    
    
    var errorTitle: String {
        switch self {
        case .generic:
            return "Error"
        case .unableToParse:
            return "Parsing Error"
        case .invalidConversionRate:
            return "Invalid Input"
        case .invalidHTTPResponse:
            return "Invalid HTTPURL Response"
        case .invalidStatusCode(let code):
            return "Invalid Status Code = \(code)"
        case .unableToRetrieveData:
            return "Network Error"
        case .invalidURL:
            return "Invalid URL"
        }
    }
    
    var errorMessages: String {
        switch self {
        case .generic:
            return "Sorry, something went wrong. Please try again"
        case .unableToParse:
            return "Unable to parse data obtained from the network call. Please try again"
        case .invalidConversionRate:
            return "The conversion rate must be a number greater than zero. Please try again."
        case .invalidHTTPResponse:
            return "Invalid HTTP response from network call. Please try again."
        case .invalidStatusCode:
            return "Invalid http status code. Please try again"
        case .unableToRetrieveData:
            return "Unable to retrieve any data from the internet. Please try again"
        case .invalidURL:
            return "Unable to create URL from string."
        }
    }
}
