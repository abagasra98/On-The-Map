//
//  UdacityService.swift
//  On The Map
//
//  Created by Abdul Bagasra on 11/12/15.
//  Copyright © 2015 TAIMS Inc. All rights reserved.
//

import Foundation
import MapKit

class UdacityService {
    // MARK: Properties
    let baseURL = NSURL(string: "https://www.udacity.com/api/session") //cut out session later
    
    // MARK: Functions
    func getLocations(username: String, password: String, completion: ([Artwork]? -> Void)) {
        validateUser(username, password: password) { (let flag) -> Void in
            if flag {
                self.getlocations({ (let locationsArray) -> Void in
                    completion(locationsArray)
                })
            }
        }
    }
    
    func validateUser(username: String, password: String, completion: (Bool -> Void)) {
        let request = NSMutableURLRequest(URL: baseURL!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\":\"\(username)\", \"password\":\"\(password)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        
        let networkOperation = NetworkOperation()
        networkOperation.downloadData(request, skipFive: true) { (let jsonDictionary) -> Void in
            if let _ = jsonDictionary!["account"] as? [String:AnyObject] {
                completion(true)
            } else {
                completion(false)
            }
        }

    }
    
    func getlocations(completion: ([Artwork]? -> Void)) {
        //var mapStringArray = [String]()
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let networkOperation = NetworkOperation()
        networkOperation.downloadData(request, skipFive: false) { (let jsonDictionary) -> Void in
            if let jsonArray = jsonDictionary!["results"] as? [[String:AnyObject]] {
                completion(self.extractLocations(jsonArray))
            }
        }
        //print(mapStringArray)
    }
    
    func extractLocations(jsonDictionary: [[String:AnyObject]]) -> [Artwork] {
        var locationsArray = [Artwork]()
        //var locationsArray = [Location]()
        for (var i = 0; i < 100; i++) {
            let dict = jsonDictionary[i]
            let firstName = dict["firstName"] as? String
            let lastName = dict["lastName"] as? String
            let fullName = firstName! + " " + lastName!
            let mediaURL = dict["mediaURL"] as? String
            let lat = dict["latitude"] as? CLLocationDegrees
            let long = dict["longitude"] as? CLLocationDegrees
            locationsArray.append(Artwork(title: fullName, mediaURL: mediaURL!, discipline: "Location", coordinate: CLLocationCoordinate2D(latitude: lat!, longitude: long!)))
        }
        return locationsArray
    }

}