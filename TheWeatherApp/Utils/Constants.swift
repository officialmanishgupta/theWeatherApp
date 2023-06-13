//
//  Constants.swift
//  TheWeatherApp
//
//  Created by Manish Gupta on 6/11/23.
//

import Foundation
import UIKit

struct Constants {
    static let appid = "019ba229d67bcb745c7686df9fd2036e"
    enum WeatherURLs {
        static var cityState = "https://api.openweathermap.org/data/2.5/weather?appid=\(appid)&units=imperial"
    }
    enum GeoURLs {
        static var latLong = "https://api.openweathermap.org/geo/1.0/reverse?appid=\(appid)"
        static var zip = "https://api.openweathermap.org/geo/1.0/zip?appid=\(appid)&units=imperial"
    }
    
    enum ImageURLs {
        static var baseURL =  "https://openweathermap.org/img/wn/"
    }
}

enum WeatherUnit: String {
    case Imperial = "imperial"
    case Metric = "metric"
}

extension UIImage {
    convenience init(url: String,
                     callbackWithImage: @escaping (Data?, Error?) -> Void) {
        if let theURL = URL(string: url) {
            URLSession.shared.dataTask(with: URLRequest(url: theURL)) { data, response, error in
                if let data = data {
                    callbackWithImage(data, nil)
                }
                if let error = error {
                    callbackWithImage(nil, error)
                }
            }.resume()
        }
        
        self.init()
    }
}
