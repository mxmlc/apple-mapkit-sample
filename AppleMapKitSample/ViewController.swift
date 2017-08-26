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

    @IBOutlet weak var mapView: MKMapView!
    
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
        
        // handle responses to map view
        mapView.delegate = self
        // enable show user location
        mapView.showsUserLocation = true
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
            // this code zoom in to user location
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}

extension ViewController: MKMapViewDelegate {
    
}
