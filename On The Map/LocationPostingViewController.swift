//
//  LocationPostingViewController.swift
//  On The Map
//
//  Created by Abdul Bagasra on 2/2/16.
//  Copyright © 2016 TAIMS Inc. All rights reserved.
//

import UIKit

class LocationPostingViewController: UIViewController, UITextFieldDelegate {
    // MARK: Properties
    var plainLocation: String?
    
    // MARK: Outlets
    @IBOutlet weak var locationTextField: UITextField! {
        didSet {
            locationTextField.delegate = self
        }
    }
    
    // MARK: View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Functions
    @IBAction func cancelPosting(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func encodeLocation(sender: AnyObject) {
        if (locationTextField.text != nil && locationTextField.text != "") {
            plainLocation = locationTextField.text
        } else {
            let alert = UIAlertController(title: "You forgot to enter a location!", message: nil, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: UITextField Delegate Methods
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == locationTextField) {
            plainLocation = textField.text
        }
        textField.resignFirstResponder()
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
