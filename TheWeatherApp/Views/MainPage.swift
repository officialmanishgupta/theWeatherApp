//
//  MainPage.swift
//  TheWeatherApp
//
//  Created by Manish Gupta on 6/11/23.
//

import SwiftUI

struct MainPage: View {
    @ObservedObject var locationVM: LocationViewModel
    @State var enteredZip: String = ""
    let backgroundGradient = LinearGradient(
        colors: [Color.red, Color.blue],
        startPoint: .top, endPoint: .bottom)
    var body: some View {
        NavigationView {
            seactionViews
                .navigationTitle("Weather")
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage(locationVM: LocationViewModel())
    }
}

extension MainPage {
    private var seactionViews: some View {
        VStack {
            VStack {
                Section {
                    // TODO: Add all literals in the constants file.
                    VStack {
                        HStack {
                            Text("Zip Code").foregroundColor(Color.gray)
                            TextField("Zip Code", text: $enteredZip)
                        }
                        Button(action: {
                            locationVM.enteredZip = enteredZip
                        }) {
                            Text("Look up")
                        }
                        Spacer()
                        if locationVM.isLocationAccessAllowed == false {
                            DeviceSettingsView(locationVM: locationVM)
                        } else {
                            Text("\(locationVM.currentLocationViaZip)")
                        }
                    }
                } header: {
                    ShowCurrentLocationView(locationVM: locationVM)
                }
                WeatherView(weatherVM: locationVM.weatherVM)
            }
            Spacer()
            List {
                
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink {
                            SidePanel(locationVM: locationVM)
                        } label: {
                            Image(systemName: "gearshape")
                        }
                    }
                }
            }
        }
    }
}
