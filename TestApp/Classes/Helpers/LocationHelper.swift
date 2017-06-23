//
//  LocationHelper.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-22.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import CoreLocation

class LocationHelper {
    
    private let manager = CLLocationManager()
    
    var latitude: Double {
        get {
            return Double(manager.location?.coordinate.latitude ?? 0.0)
        }
    }
    
    var longitude: Double {
        get {
            return Double(manager.location?.coordinate.latitude ?? 0.0)
        }
    }
    
    var enabled: Bool {
        get {
            if CLLocationManager.locationServicesEnabled() {
                switch(CLLocationManager.authorizationStatus()) {
                case .notDetermined, .restricted, .denied:
                    return false
                case .authorizedAlways, .authorizedWhenInUse:
                    return true
                }
            } else {
                return false
            }
        }
    }
    
    func authorize() {
        if CLLocationManager.locationServicesEnabled() {
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
    }
    
}

