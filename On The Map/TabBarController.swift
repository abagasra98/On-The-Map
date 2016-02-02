//
//  TabBarController.swift
//  On The Map
//
//  Created by Abdul Bagasra on 1/13/16.
//  Copyright © 2016 TAIMS Inc. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    // MARK: Properties
    var locationsArray: [Artwork]?
    
    // MARK: UI Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITabBarControllerDelegate Methods
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController)  {
        if let destinationVC = viewController as? UINavigationController {
            if let tableVC = destinationVC.topViewController as? LocationsTableView {
                let locationArrays = locationsArray!.splitBy(10)
                tableVC.locationsArray = locationArrays
            }
        } else if let destinationVC = viewController as? MapViewController {
            destinationVC.locationsArray = locationsArray
        }
    }
    
    //if let mapVC = tabBarController.viewControllers![0] as? MapViewController

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
