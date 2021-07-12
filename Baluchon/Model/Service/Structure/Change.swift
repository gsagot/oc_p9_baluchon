//
//  Change.swift
//  Baluchon
//
//  Created by Gilles Sagot on 27/06/2021.
//

import Foundation

struct Rates: Codable {
    var USD: Double
    
}

struct ChangeResult: Codable {
    var base: String
    var rates: Rates
}
