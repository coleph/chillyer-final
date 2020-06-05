//
//  LocationManager.swift
//  Cate Sports App
//
//  Created by Ian Mabon on 4/28/20.
//  Copyright © 2020 Ian Mabon. All rights reserved.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
//    var delegate: LocationFetcherDelegate?
// I dont know Ian
    
    override init() {
        super.init()
        manager.delegate = self
        start()
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
