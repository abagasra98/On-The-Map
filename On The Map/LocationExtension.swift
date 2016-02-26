//
//  LocationExtension.swift
//  On The Map
//
//  Created by Abdul Bagasra on 2/26/16.
//  Copyright © 2016 TAIMS Inc. All rights reserved.
//

import Foundation
import MapKit

extension LocationPostingViewController {
    
    // MARK: UITextField Delegate Methods
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == locationTextField) {
            plainLocation = textField.text
        }
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: MKMapView Delegate Methods
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Artwork {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                dequedView.annotation = annotation
                view = dequedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
    
    // MARK: CLLocationManager Delegate Methods
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            currentLocation = location
            locationManager.stopUpdatingLocation()
        }
    }
    
}