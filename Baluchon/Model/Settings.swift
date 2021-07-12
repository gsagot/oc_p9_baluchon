//
//  Baluchon.swift
//  Baluchon
//
//  Created by Gilles Sagot on 08/07/2021.
//

import Foundation

class Settings {
    
    static var shared = Settings()
    
    private init() {}
    
    
    // MARK: - FUNCTIONS
    
    func formatTextForURLRequest(string:String)-> String {
        return string.replacingOccurrences(of: " ", with: "+")
    }
    
    
    
    

}
