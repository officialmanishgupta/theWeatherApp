//
//  WeatherModels.swift
//  TheWeatherApp
//
//  Created by Manish Gupta on 6/12/23.
//

import Foundation
import UIKit

final class WeatherDetails: Decodable {
    var weather: [Weather]
    var main: Main
    var wind: Wind
    var sys: Sys
    
    struct Main: Decodable {
        var currentTemp: Double
        var feelsLikeTemp: Double
        var minTemp: Double
        var maxTemp: Double
        var humidity: Int
        
        enum CodingKeys: String, CodingKey {
            case currentTemp = "temp"
            case feelsLikeTemp = "feels_like"
            case minTemp = "temp_min"
            case maxTemp = "temp_max"
            case humidity = "humidity"
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<WeatherDetails.Main.CodingKeys> = try decoder.container(keyedBy: WeatherDetails.Main.CodingKeys.self)
            self.currentTemp = try container.decode(Double.self, forKey: WeatherDetails.Main.CodingKeys.currentTemp)
            self.feelsLikeTemp = try container.decode(Double.self, forKey: WeatherDetails.Main.CodingKeys.feelsLikeTemp)
            self.minTemp = try container.decode(Double.self, forKey: WeatherDetails.Main.CodingKeys.minTemp)
            self.maxTemp = try container.decode(Double.self, forKey: WeatherDetails.Main.CodingKeys.maxTemp)
            self.humidity = try container.decode(Int.self, forKey: WeatherDetails.Main.CodingKeys.humidity)
            
            print("++++++++++++++++++++\(self.currentTemp)++++++++++++++++++++++++++++++++")
        }
    }
    
    struct Wind: Decodable {
        var speed: Double
        
        enum CodingKeys: String, CodingKey {
            case speed
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<WeatherDetails.Wind.CodingKeys> = try decoder.container(keyedBy: WeatherDetails.Wind.CodingKeys.self)
            self.speed = try container.decode(Double.self, forKey: WeatherDetails.Wind.CodingKeys.speed)
        }
    }
    
    struct Sys: Decodable {
        var sunrise: Int
        var sunset: Int
        var sunsetString: String
        var sunriseString: String
        
        enum CodingKeys: String, CodingKey {
            case sunrise, sunset
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<WeatherDetails.Sys.CodingKeys> = try decoder.container(keyedBy: WeatherDetails.Sys.CodingKeys.self)
            self.sunrise = try container.decode(Int.self, forKey: WeatherDetails.Sys.CodingKeys.sunrise)
            self.sunset = try container.decode(Int.self, forKey: WeatherDetails.Sys.CodingKeys.sunset)
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.timeStyle = .short
            
            sunsetString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self.sunset)))
            sunriseString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self.sunrise)))
        }
    }
    
    final class Weather: Decodable, ObservableObject {
        @Published var iconImage: UIImage?
        var id: Int
        var main: String
        var description: String
        var icon: String
        var imageName: String
        var iconData: Data?
        var imageURL: String
        
        enum CodingKeys: String, CodingKey {
            case id, main, description, icon
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<WeatherDetails.Weather.CodingKeys> = try decoder.container(keyedBy: WeatherDetails.Weather.CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: WeatherDetails.Weather.CodingKeys.id)
            self.main = try container.decode(String.self, forKey: WeatherDetails.Weather.CodingKeys.main)
            self.description = try container.decode(String.self, forKey: WeatherDetails.Weather.CodingKeys.description)
            self.icon = try container.decode(String.self, forKey: WeatherDetails.Weather.CodingKeys.icon)
            self.imageName = self.icon + "@2x.png"
            self.imageURL = Constants.ImageURLs.baseURL + self.imageName
//            let anImage = UIImage(url:  imageURL) { [weak self] data, error in
//                if let data = data {
//                    DispatchQueue.main.async {
//                        self?.iconData = data
//                        self?.iconImage = UIImage(data: data)
//                    }
//                }
//            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case weather, main, wind, sys
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.weather = try container.decode([WeatherDetails.Weather].self, forKey: .weather)
        self.main = try container.decode(WeatherDetails.Main.self, forKey: .main)
        self.wind = try container.decode(WeatherDetails.Wind.self, forKey: .wind)
        self.sys = try container.decode(WeatherDetails.Sys.self, forKey: .sys)
    }
}
