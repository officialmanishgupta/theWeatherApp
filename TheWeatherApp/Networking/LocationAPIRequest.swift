//
//  LocationAPIRequest.swift
//  TheWeatherApp
//
//  Created by Manish Gupta on 6/9/23.
//

import Foundation
import Combine

final class LocationAPIRequest {
    private var subscription: Set<AnyCancellable> = Set<AnyCancellable>()
    init(lat: String, long: String,
         returnMe: @escaping ([LocationDetails?]) -> Void) {
        var url = Constants.GeoURLs.latLong
        url.append("&lat=\(lat)")
        url.append("&lon=\(long)")
        locationViaLatLong(url) { locationDetails in
            if let locationDetails = locationDetails {
                returnMe(locationDetails)
            }
        }
    }
    
    init(zipCode: String,
         returnMe: @escaping (LocationDetailsViaZip?) -> Void) {
        var url = Constants.GeoURLs.zip
        url.append("&zip=\(zipCode),US")
        
        locationViaZip(url) { locationDetails in
            if let locationDetails = locationDetails {
                returnMe(locationDetails)
            }
        }
    }
    
    private func locationViaLatLong(_ url: String,
                              toReturn: @escaping ([LocationDetails]?) -> Void) {
        if let theURL = URL(string: url) {
            URLSession.shared.dataTaskPublisher(for: theURL)
                .map({ data, response in
                    return data
                })
                .decode(type: [LocationDetails].self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: { locationDetails in
                    toReturn(locationDetails)
                }.store(in: &subscription)

        }
    }
    
    private func locationViaZip(_ url: String,
                              toReturn: @escaping (LocationDetailsViaZip?) -> Void) {
        if let theURL = URL(string: url) {
            URLSession.shared.dataTaskPublisher(for: theURL)
                .map({ data, response in
                    return data
                })
                .decode(type: LocationDetailsViaZip.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: { locationDetails in
                    print(locationDetails)
                    toReturn(locationDetails)
                }.store(in: &subscription)

        }
    }
}
