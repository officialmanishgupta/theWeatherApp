//
//  WeatherAPIRequest.swift
//  TheWeatherApp
//
//  Created by Manish Gupta on 6/12/23.
//

import Foundation
import Combine

final class WeatherAPIRequest {
    private var subscription: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(cityState: String,
         returnMe: @escaping (WeatherDetails?) -> Void) {
        var url = Constants.WeatherURLs.cityState
        url.append("&q=\(cityState)")
        
        // Encode the url
        let newURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "\(url)"
//        print("-------------------------\(newURL)-------------------------")
            weatherDetailsWithCityState(newURL) { weatherDetails in
            if let weatherDetails = weatherDetails {
                returnMe(weatherDetails)
            }
        }
    }

    private func weatherDetailsWithCityState(_ url: String,
                              toReturn: @escaping (WeatherDetails?) -> Void) {
        if let theURL = URL(string: url) {
            URLSession.shared.dataTaskPublisher(for: theURL)
                .map({ data, response in
                    return data
                })
                .decode(type: WeatherDetails.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: { weatherDetails in
                    toReturn(weatherDetails)
                }.store(in: &subscription)

        }
    }
}

let currentWeather =
"""
{
"coord": {
  "lon": -81.6556,
  "lat": 30.3322
},
"weather": [
  {
    "id": 701,
    "main": "Mist",
    "description": "mist",
    "icon": "50d"
  }
],
"base": "stations",
"main": {
  "temp": 23.98,
  "feels_like": 24.86,
  "temp_min": 22.02,
  "temp_max": 26.14,
  "pressure": 1012,
  "humidity": 93
},
"visibility": 6437,
"wind": {
  "speed": 1.54,
  "deg": 20
},
"clouds": {
  "all": 40
},
"dt": 1686400922,
"sys": {
  "type": 2,
  "id": 2037733,
  "country": "US",
  "sunrise": 1686392657,
  "sunset": 1686443281
},
"timezone": -14400,
"id": 4160021,
"name": "Jacksonville",
"cod": 200
}
"""
