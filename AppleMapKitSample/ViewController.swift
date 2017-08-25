//
//  ViewController.swift
//  AppleMapKitSample
//
//  Created by Fabiano Ramos dos Santos on 24/08/17.
//  Copyright © 2017 Fabiano Ramos dos Santos. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // handle responses asynchronously
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // trigger location permission dialog
        locationManager.requestWhenInUseAuthorization()
        // trigger a one-time location request
        locationManager.requestLocation()
    }

}

extension ViewController: CLLocationManagerDelegate {
    // called when the user responds to the permission dialog
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    // called when location information comes back
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location:: \(location)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}

