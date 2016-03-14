//
//  LocationPostingViewController.swift
//  On The Map
//
//  Created by Abdul Bagasra on 2/2/16.
//  Copyright © 2016 TAIMS Inc. All rights reserved.
//

import UIKit
import MapKit

class LocationPostingViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    // MARK: Properties
    var plainLocation: String?
    var currentLocation: CLLocation?
    let locationManager = CLLocationManager()
    
    // MARK: Outlets
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var locationView: UIView!
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
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
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
        reverseGeoCoding({ (let coordinate) -> Void in // Implement alert that shows if error
            self.prepareForMapDisplay()
            self.displayMap(coordinate!)
        })
    }
    
    @IBAction func getCurrentLocation(sender: UIButton) {
        if (currentLocation != nil) {
            print(currentLocation)
            self.prepareForMapDisplay()
            self.displayMap((currentLocation?.coordinate)!)
        } else {
            let alert = UIAlertController(title: "Your Current Location Could Not Be Determined", message: nil, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }
    
    func reverseGeoCoding(completionHandler: (CLLocationCoordinate2D? -> Void)) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(plainLocation!) { (let placemarks, let error) -> Void in
            if (error != nil) {
                print("Geocode failed with error: \(error!.localizedDescription)")
            } else if (placemarks!.count > 0) {
                let placemark = placemarks![0]
                completionHandler((placemark.location?.coordinate)!)
            }
        }
    }
    
    func prepareForMapDisplay() {
        displayLabel.text = plainLocation
        displayLabel.textColor = UIColor.whiteColor()
        topView.backgroundColor = UIColor(red: 81.0/255.0, green: 137.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        bottomView.hidden = true
        locationTextField.hidden = true
        mapView.hidden = false
    }
    
    func displayMap(coordinate: CLLocationCoordinate2D) {
        let artwork = Artwork(coordinate: coordinate)
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 100, 100)
        //self.mapView.setCenterCoordinate(coordinate, animated: true)
        self.mapView.setRegion(region, animated: true)
        self.mapView.addAnnotation(artwork)
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
        if (locationTextField.isFirstResponder()) {
            locationTextField.resignFirstResponder()
        }
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
