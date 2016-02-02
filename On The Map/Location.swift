//
//  Location.swift
//  On The Map
//
//  Created by Abdul Bagasra on 11/24/15.
//  Copyright © 2015 TAIMS Inc. All rights reserved.
//

import Foundation

class Location: CustomStringConvertible {
    // MARK: Properties
    let latitude: Double?
    let longitude: Double?
    var description: String {
        return "Latitude: \(latitude), Longitude: \(longitude)"
    }
    
    // MARK: Initializer
    init(lat: Double, long: Double) {
        latitude = lat
        longitude = long
    }
}
