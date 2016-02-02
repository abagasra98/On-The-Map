//
//  ArrayExtension.swift
//  On The Map
//
//  Created by Abdul Bagasra on 1/21/16.
//  Copyright © 2016 TAIMS Inc. All rights reserved.
//

import Foundation

extension Array {
    func splitBy(subSize: Int) -> [[Element]] {
        return 0.stride(to: self.count, by: subSize).map { startIndex in
            let endIndex = startIndex.advancedBy(subSize, limit: self.count)
            return Array(self[startIndex ..< endIndex])
        }
    }
}