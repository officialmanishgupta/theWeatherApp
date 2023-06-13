//
//  WeatherViewModel.swift
//  TheWeatherApp
//
//  Created by Manish Gupta on 6/12/23.
//

import Foundation
import UIKit

final class WeatherViewModel: ObservableObject {
    var currentLocationWithZip: String = ""
    var currentLocationWithCityState: String = ""
    @Published var updatedWeatherDetails: WeatherDetails?
    private var weatherDetails: WeatherDetails? {
        didSet {
            updatedWeatherDetails = weatherDetails
        }
    }
    
    private var service: WeatherAPIRequest?
    
    func requestWeatherDetails(for city: String) {
        self.service = WeatherAPIRequest(cityState: city, returnMe: { [weak self] details in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.weatherDetails = details
            }
        })
    }
}
