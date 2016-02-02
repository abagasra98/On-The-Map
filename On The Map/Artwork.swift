//
//  Artwork.swift
//  On The Map
//
//  Created by Abdul Bagasra on 12/11/15.
//  Copyright © 2015 TAIMS Inc. All rights reserved.
//

import Foundation
import MapKit

class Artwork: NSObject, MKAnnotation {
    // MARK: Properties
    let title: String?
    let mediaURL: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    var subtitle: String? {
        return mediaURL
    }
    
    // MARK: Initalizers
    init(title: String, mediaURL: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.mediaURL = mediaURL
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    
}
