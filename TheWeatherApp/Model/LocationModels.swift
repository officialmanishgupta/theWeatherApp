//
//  LocationModels.swift
//  TheWeatherApp
//
//  Created by Manish Gupta on 6/11/23.
//

import Foundation

struct LocationDetails: Decodable {
    var locationName: String
    var state: String
    
    enum Keys: String, CodingKey {
        case locationName = "name"
        case state = "state"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        locationName = try container.decodeIfPresent(String.self, forKey:  .locationName) ?? "No name received"
        state = try container.decodeIfPresent(String.self, forKey: .state) ?? "NY"
    }
}

struct LocationDetailsViaZip: Decodable {
    var locationName: String
    var country: String
    
    enum Keys: String, CodingKey {
        case locationName = "name"
        case country = "country"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        locationName = try container.decodeIfPresent(String.self, forKey:  .locationName) ?? ""
        country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
    }
}
