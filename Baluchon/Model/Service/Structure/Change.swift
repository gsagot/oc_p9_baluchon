//
//  Change.swift
//  Baluchon
//
//  Created by Gilles Sagot on 27/06/2021.
//

import Foundation

struct Rates: Codable {
    var USD: Double
    var EUR: Double
    var GBP: Double
    var CHF: Double
    
}

struct ChangeResult: Codable {
    var base: String
    var rates: Rates
}

struct Currency {
    var code:String
    var name:String
    var rate:Double
    var icon:String
    var amount:Double
}
