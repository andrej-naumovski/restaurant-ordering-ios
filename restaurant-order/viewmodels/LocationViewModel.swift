//
//  LocationViewModel.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/3/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import RxSwift
import CoreLocation

class LocationViewModel: NSObject, CLLocationManagerDelegate {
    var latLng = Variable<LatLng?>(nil)
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func updateUserLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.last?.coordinate {
            latLng.value = LatLng(latitude: userLocation.latitude, longitude: userLocation.longitude)
            locationManager.stopUpdatingLocation()
        }
    }
}
