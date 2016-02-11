//
//  LocationPostingViewController.swift
//  On The Map
//
//  Created by Abdul Bagasra on 2/2/16.
//  Copyright © 2016 TAIMS Inc. All rights reserved.
//

import UIKit
import MapKit

class LocationPostingViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate {
    // MARK: Properties
    var plainLocation: String?
    
    // MARK: Outlets
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
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
        verifyTextField()
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(plainLocation!) { (let placemarks, let error) -> Void in
            if (error != nil) {
                print("Geocode failed with error: \(error!.localizedDescription)")
            } else if (placemarks!.count > 0) {
                self.prepareForMapDisplay()
                let placemark = placemarks![0]
                let coordinates = placemark.location?.coordinate
                let artwork = Artwork(coordinate: coordinates!)
                self.mapView.addAnnotation(artwork)
            }
        }
        
    }
    
    func prepareForMapDisplay() {
        displayLabel.text = plainLocation
        locationView.hidden = true
        bottomView.hidden = true
        mapView.hidden = false
    }
    
    func verifyTextField() {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
