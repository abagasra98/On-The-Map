//
//  HashTable.swift
//  On The Map
//
//  Created by Abdul Bagasra on 1/26/16.
//  Copyright © 2016 TAIMS Inc. All rights reserved.
//

import Foundation

class HashTable {
    // MARK: Properties
    var table = [Int:Artwork]()
    //var table = [Int:String]()
    var size = 0
    
    // MARK: Functions
    func put(key: Int, value: Artwork) -> Bool {
        let valueAtIndex = table[key]
        if (valueAtIndex?.title == value.title) {
            return false
        } else if (valueAtIndex != nil) {
            print("Collision")
        } else {
            table[key] = value
            size = size + 1
        }
        return true
    }
    
    func remove(key: Int) -> Bool {
        if table.removeValueForKey(key) != nil {
            size = size - 1
            return true
        }
        return false
    }
    
    func convertToArray() -> [Artwork] {
        var locationArray = [Artwork]()
        for artwork in table.values {
            locationArray.append(artwork)
        }
        return locationArray
    }
    
    func resolveCollision(keyIndex: Int) {
        // Need to develop a function that enables back-tracing, the key can be transmitted or stored somehow
    }
    
}
