//
//  WeatherView.swift
//  TheWeatherApp
//
//  Created by Manish Gupta on 6/11/23.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var weatherVM: WeatherViewModel
    var body: some View {
        HStack {
            Spacer()
            VStack {
                let imageURL = weatherVM.updatedWeatherDetails?.weather.first?.imageURL ?? ""
                if #available(iOS 15.0, *) {
                    AsyncImage(url: URL(string: imageURL)) { returnedImage in
                        returnedImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .center)
                    } placeholder: {
                        Image(systemName: "cloud.heavyrain")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }

                } else {
                    // Fallback on earlier versions
                    
                }
                HStack {
                    Text("\(Int(weatherVM.updatedWeatherDetails?.main.currentTemp ?? 70).description)℉")
                        .font(.system(size: 72))
                }
                
                HStack {
                    Text("\(weatherVM.updatedWeatherDetails?.weather.first?.description.description.capitalized ?? "")")
                }
                Spacer()
                HStack {
                    Text("L:")
                    Text("\(Int(weatherVM.updatedWeatherDetails?.main.minTemp ?? 75).description)℉")
                }
                HStack {
                    Text("H:")
                    Text("\(Int(weatherVM.updatedWeatherDetails?.main.maxTemp ?? 85).description)℉")
                }
                HStack {
                    Spacer()
                    Text("Feels Like Temp:")
                    Text("\(Int(weatherVM.updatedWeatherDetails?.main.feelsLikeTemp ?? 85).description)℉")
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("Humidity:")
                    Text("\(weatherVM.updatedWeatherDetails?.main.humidity.description ?? "55")%")
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("Wind Speed:")
                    Text("\(weatherVM.updatedWeatherDetails?.wind.speed.description ?? "5") m/hr")
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Text("Sunrise:")
                    Text("\(weatherVM.updatedWeatherDetails?.sys.sunriseString ?? "7:00 am")")
                    Spacer()
                    Text("Sunset:")
                    Text("\(weatherVM.updatedWeatherDetails?.sys.sunsetString ?? "8:30 pm")")
                    
                    Spacer()
                }
                
            }
            Spacer()
        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 40, trailing: 20))
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weatherVM: WeatherViewModel())
    }
}
