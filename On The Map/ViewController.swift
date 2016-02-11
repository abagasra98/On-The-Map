//
//  ViewController.swift
//  On The Map
//
//  Created by Abdul Bagasra on 11/8/15.
//  Copyright © 2015 TAIMS Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    // MARK: Properties
    var email: String?
    var password: String?
    var locationsArray: [Artwork]?
    
    // MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Functions
    @IBAction func loginToUdacity(sender: UIButton) {
        verifyTextField()
        if (email != nil && password != nil) {
            let udacityService = UdacityService()
            udacityService.getLocations(email!, password: password!, completion: { (let locationData) -> Void in
                self.locationsArray = self.removeDuplicates(locationData!)
                //self.removeDuplicates(self.locationsArray!)
                self.performSegueWithIdentifier("showMap", sender: self)
            })
        }
    }

    @IBAction func signupForUdacity(sender: UIButton) {
    }
    
    @IBAction func loginToFacebook(sender: UIButton) {
    }
    
    func removeDuplicates(locationsArray: [Artwork]) -> [Artwork] {
        let hashTable = HashTable()
        //var hashTable = [Int:String]()
        for location in locationsArray {
            let title = location.title
            let hashCode = (title?.hash)! //% locationsArray.count
            hashTable.put(hashCode, value: location)
            //hashTable[hashCode] = title
        }
        return hashTable.convertToArray()
    }
    
    func verifyTextField() {
        if let emailText = emailTextField.text, passText = passwordTextField.text { //Find a way to resign 1st responder status
            email = emailText
            password = passText
        } else {
            let alert = UIAlertController(title: "You forgot to enter the login information!", message: nil, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap" {
            if let tabBarController = segue.destinationViewController as? TabBarController {
                tabBarController.locationsArray = locationsArray
                if let navController = tabBarController.viewControllers![0] as? UINavigationController {
                    if let mapVC = navController.topViewController as? MapViewController {
                        mapVC.locationsArray = locationsArray
                    }
                }
            }
        }
    }
    
    // MARK: UITextFieldDelegate Methods
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == emailTextField {
            email = textField.text
        } else if (textField == passwordTextField) {
            password = textField.text
        }
        textField.resignFirstResponder()
        return true
    }
    
    
}

