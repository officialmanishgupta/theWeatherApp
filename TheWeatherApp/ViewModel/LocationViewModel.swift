//
//  LocationViewModel.swift
//  TheWeatherApp
//
//  Created by Manish Gupta on 6/11/23.
//

import Foundation
import CoreLocation

final class LocationViewModel: ObservableObject {
    @Published var isLocationAccessAllowed: Bool = false
    @Published var currentLocation: String = ""
    @Published var currentLocationViaZip: String = ""
    
    var weatherVM: WeatherViewModel = WeatherViewModel()
    var enteredZip: String = "" {
        didSet {
            currentLocationViaZip(zip: enteredZip)
        }
    }
    
    private (set) var locationObject: [LocationDetails?] = []
    private (set) var locationObjectViaZip: LocationDetailsViaZip?
    private var latLong: (String, String)?
    private var service: LocationAPIRequest?
    
    init() {}
    
    /// Verifies if location permission was provided by the user
    func checkForLocationAccess() {
        let locationPermission = LocationPermissionManager.sharedInstance
        locationPermission.verifyLocationPermission { [weak self] isAllowed in
            guard let self = self else { return }
            self.isLocationAccessAllowed = isAllowed
            if isAllowed {
                self.latLong = locationPermission.latLong
                self.currentLatAndLong()
            }
        }
    }
    
    /// Gets the latitude and longitude for the current location and brings the location
    private func currentLatAndLong() {
        self.service = LocationAPIRequest(lat: latLong?.0 ?? "37.32",
                               long: latLong?.1 ?? "122.03") { [weak self] locationDetails in
            guard let self = self else { return }
            if locationDetails.count > 0 {
                DispatchQueue.main.async {
                    self.locationObject = locationDetails
                    self.currentLocation =
                    "\(locationDetails[0]?.locationName ?? ""), \(locationDetails[0]?.state ?? "")"
                    self.weatherVM.currentLocationWithCityState =   "\(locationDetails[0]?.locationName ?? ""),\(locationDetails[0]?.state ?? "")"
                    self.weatherVM.requestWeatherDetails(for: self.weatherVM.currentLocationWithCityState)
                }
            }
        }
    }
    
    private func currentLocationViaZip(zip: String) {
        self.service = LocationAPIRequest(zipCode: zip, returnMe: { [weak self] locationDetailsViaZip in
            guard let self = self else { return }
            if let locationDetailsViaZip = locationDetailsViaZip {
                DispatchQueue.main.async {
                    self.currentLocationViaZip =
                    "\(locationDetailsViaZip.locationName), \(locationDetailsViaZip.country)"
                    self.weatherVM.currentLocationWithCityState = "\(locationDetailsViaZip.locationName),\(locationDetailsViaZip.country)"
                    
                    self.weatherVM.requestWeatherDetails(for: self.weatherVM.currentLocationWithCityState)
                }
            }
        })
    }
}
