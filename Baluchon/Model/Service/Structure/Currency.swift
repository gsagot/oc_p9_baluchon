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

struct CurrencyResult: Codable {
    var base: String
    var date: String
    var rates: Rates
    
}

struct Currency {
    var code:String
    var rate:Double
    var icon:String
    var date:String
}
