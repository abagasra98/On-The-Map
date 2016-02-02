//
//  NetworkOperation.swift
//  On The Map
//
//  Created by Abdul Bagasra on 11/8/15.
//  Copyright © 2015 TAIMS Inc. All rights reserved.
//

import Foundation

class NetworkOperation {
    // MARK: Properties
    //let email: String?
    //let pass: String?
    typealias jsonDictionaryCompletion = ([String:AnyObject]?) -> Void

    /*
    // MARK: Initializer
    init (email: String, password: String) {
        self.email = email
        pass = password
    }
    */
    
    func downloadData(request: NSURLRequest, skipFive: Bool, completion: jsonDictionaryCompletion) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (var data, let response, let error) -> Void in
            if let httpRequest = response as? NSHTTPURLResponse {
                switch httpRequest.statusCode {
                case 200:
                    if error != nil {
                        print("Exception caught while accessing Udacity")
                    }
                    
                    if skipFive {
                        data = data?.subdataWithRange(NSMakeRange(5, (data?.length)!-5))
                    }
                    
                    do {
                        let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? [String:AnyObject]
                        completion(jsonDictionary)
                    } catch {
                        print("Failed to get JSON Dictionary")
                    }
                    //print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                default:
                    print("Error Code: \(httpRequest.statusCode)")
                }
            } else {
              print("Not a valid URL")
            }
        }
        task.resume()
    }

    /*
    func oldDownloadData(completion: jsonDictionaryCompletion) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.HTTPBody = "{\"udacity\": {\"username\":\"jderken98@aol.com\", \"password\":\"1234abcd\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = "{\"udacity\": {\"username\":\"\(email!)\", \"password\":\"\(pass!)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (let data, let request, let error) -> Void in
            if let httpRequest = request as? NSHTTPURLResponse {
                switch httpRequest.statusCode {
                case 200:
                    if error != nil {
                        print("Exception caught while accessing Udacity")
                    }
                    let newData = data?.subdataWithRange(NSMakeRange(5, (data?.length)!-5))
                    do {
                        let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(newData!, options: .MutableContainers) as? [String:AnyObject]
                        completion(jsonDictionary)
                    } catch {
                        print("Failed to get JSON Dictionary")
                    }
                    print(NSString(data: newData!, encoding: NSUTF8StringEncoding))
                default:
                    print("Error Code: \(httpRequest.statusCode)")
                }
            } else {
                print("Not a valid URL")
            }
            
        }
        task.resume()
    }
    */
}
