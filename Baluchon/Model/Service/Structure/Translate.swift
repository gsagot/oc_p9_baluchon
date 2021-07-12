//
//  Translate.swift
//  Baluchon
//
//  Created by Gilles Sagot on 27/06/2021.
//

import Foundation

struct Translations: Codable {
    var translatedText: String
}


struct Data: Codable {
    var translations: [Translations]
    
}

struct TranslationResult: Codable {
    var data: Data
}
