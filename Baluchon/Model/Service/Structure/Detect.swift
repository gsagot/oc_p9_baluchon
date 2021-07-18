//
//  Detect.swift
//  Baluchon
//
//  Created by Gilles Sagot on 14/07/2021.
//

import Foundation

struct Detections: Codable {
    var language: String
}


struct DataWithDetection: Codable {
    var detections: [[Detections]]
}

struct DetectionResult: Codable {
    var data: DataWithDetection
}
