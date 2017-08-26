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
    
    var resultSearchController: UISearchController? = nil
    
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
        
        // instantiate the search view by its ID
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        locationSearchTable.mapView = mapView;
        
        // configure the search bar and embed it to the navigation bar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        // determines that the navigation bar disappears when search results are shown
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        // show the modal semi-transparent overlay
        resultSearchController?.dimsBackgroundDuringPresentation = true
        // limits the overlap area to just the ViewController and not the entire NavigationController
        definesPresentationContext = true
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
