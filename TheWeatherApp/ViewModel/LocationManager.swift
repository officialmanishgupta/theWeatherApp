//
//  LocationManager.swift
//  TheWeatherApp
//
//  Created by Manish Gupta on 6/11/23.
//

import Foundation
import CoreLocation

typealias LocationCallback = (Bool) -> Void

/// Manager to manage the locations related preferences.
final class LocationPermissionManager: NSObject {
    private var locationManager = CLLocationManager()
    private var hasLocationAcces: Bool = false
    private var locationAccess: Bool {
        get {
            hasLocationAcces = (CLLocationManager.locationServicesEnabled() &&
             (locationManager.authorizationStatus == .authorizedAlways ||
              locationManager.authorizationStatus == .authorizedWhenInUse))
            return hasLocationAcces
        }
        set {
            hasLocationAcces = newValue
        }
    }
    var locationVM: LocationViewModel = LocationViewModel()
    var latLong: (String, String) {
        if locationAccess == true {
            return ("\(locationManager.location?.coordinate.latitude ?? 37.3230)",
                    "\(locationManager.location?.coordinate.longitude ?? 122.0322)")
        }
        return ("37.3230", "122.0322")
    }
    
    
    static let sharedInstance = LocationPermissionManager()
    private override init() {}
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func verifyLocationPermission(callback: LocationCallback?) {
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                callback?(true)
            default:
                locationManager.requestWhenInUseAuthorization()
                locationManager.delegate = self
                callback?(false)
            }
        }
    }
}

extension LocationPermissionManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        locationAccess = manager.authorizationStatus == .authorizedAlways ||
        manager.authorizationStatus == .authorizedWhenInUse
    }
}
