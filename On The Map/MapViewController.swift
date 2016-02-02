//
//  MapViewController.swift
//  On The Map
//
//  Created by Abdul Bagasra on 11/19/15.
//  Copyright © 2015 TAIMS Inc. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    // MARK: Properties
    var locationsArray: [Artwork]?
    
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.addAnnotations(locationsArray!)
        //mapView.addAnnotations(locationsArray!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
