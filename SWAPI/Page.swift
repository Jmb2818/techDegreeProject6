//
//  Page.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/15/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import Foundation

struct Page<T: Codable>: Codable {
    var results: [T]
    let count: Int
    let next: String?
}
