//
//  Result.swift
//  SWAPI
//
//  Created by Joshua Borck on 2/18/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import Foundation

typealias ResultCompletion<T> = (Result<T>) -> Void

enum Result<T> {
    case success(T)
    case failure(Error)
}
