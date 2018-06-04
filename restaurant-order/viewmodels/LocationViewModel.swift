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
    let latLng = Variable<LatLng?>(nil)
    let isPermissionDenied = Variable<Bool>(false)
    let isPermissionChecked = Variable<Bool>(false)
    
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func updateUserLocation() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.startUpdatingLocation()
                isPermissionDenied.value = false
                isPermissionChecked.value = true
            case .denied, .restricted:
                if isPermissionChecked.value {
                    isPermissionDenied.value = true
                }
            default:
                return
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.last?.coordinate {
            latLng.value = LatLng(latitude: userLocation.latitude, longitude: userLocation.longitude)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            isPermissionChecked.value = true
            isPermissionDenied.value = false
        case .denied, .restricted:
            isPermissionDenied.value = true
            isPermissionChecked.value = true
        }
    }
}
