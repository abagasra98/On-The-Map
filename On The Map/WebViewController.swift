//
//  WebViewController.swift
//  On The Map
//
//  Created by Abdul Bagasra on 2/2/16.
//  Copyright © 2016 TAIMS Inc. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    // MARK: Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView! {
        didSet {
            webView.delegate = self
        }
    }
    
    // MARK: Properties
    var urlRequest: NSURLRequest?
    var websiteURL: NSURL?

    // MARK: View Controller Lifecycle
    override func viewDidLoad() { // Add a way to determine webpage title and set it on top
        super.viewDidLoad()
        webView.userInteractionEnabled = true
        urlRequest = NSURLRequest(URL: websiteURL!)
        webView.loadRequest(urlRequest!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.intocs.club
    }
    
    // MARK: Functions
    @IBAction func backButtonTapped(sender: AnyObject) {
        webView.goBack()
    }
    
    @IBAction func forwardButtonTapped(sender: AnyObject) {
        webView.goForward()
    }
    
    @IBAction func pageSwiped(sender: UISwipeGestureRecognizer) {
        if (sender.direction == UISwipeGestureRecognizerDirection.Left) {
            webView.goBack()
        } else if (sender.direction == UISwipeGestureRecognizerDirection.Right) {
            webView.goForward()
        }
    }
    
    
    // MARK: UIWebViewDelegate Methods
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
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
