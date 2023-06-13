//
//  DeviceSettingsView.swift
//  TheWeatherApp
//
//  Created by Manish Gupta on 6/12/23.
//

import SwiftUI

struct DeviceSettingsView: View {
    @ObservedObject var locationVM: LocationViewModel
    var body: some View {
        VStack {
            if !locationVM.isLocationAccessAllowed {
                Button("Change Your Location Preferences") {
                    if let settingsWithURL = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsWithURL)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceSettingsView(locationVM: LocationViewModel())
    }
}
