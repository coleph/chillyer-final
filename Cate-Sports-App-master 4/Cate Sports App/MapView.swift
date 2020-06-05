//
//  MapView.swift
//  Cate Sports App
//
//  Created by Ian Mabon on 4/28/20.
//  Copyright © 2020 Ian Mabon. All rights reserved.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    
     let locationManager = LocationFetcher()
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        let annotation = MKPointAnnotation()
        annotation.title = "Cate School"
        annotation.subtitle = "Go Rams!"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 34.405, longitude: -119.4774)
        mapView.addAnnotation(annotation)
    
        //current location
//        let lastKnownLocation = MKPointAnnotation()
//        lastKnownLocation.title = "Current Location"
//        lastKnownLocation.coordinate = CLLocationCoordinate2D(latitude: locationManager.lastKnownLocation!.latitude, longitude: locationManager.lastKnownLocation!.longitude)
//        mapView.addAnnotation(lastKnownLocation)
        
        return mapView
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        let coordinate = CLLocationCoordinate2D(latitude: 34.405, longitude: -119.4774)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        uiView.setRegion(region, animated: true)
        
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
