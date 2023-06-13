//
//  ShowCurrentLocationView.swift
//  TheWeatherApp
//
//  Created by Manish Gupta on 6/12/23.
//

import SwiftUI

struct ShowCurrentLocationView: View {
    @ObservedObject var locationVM: LocationViewModel
    var body: some View {
        VStack {
            HStack {
                if locationVM.isLocationAccessAllowed {
                    Image(systemName: "location.fill")
                    Text("\(locationVM.currentLocation)")
                } else {
                    Image(systemName: "location")
                    Text("Current Location: Unknown")
                }
            }
        }
    }
}

struct ShowCurrentView_Previews: PreviewProvider {
    static var previews: some View {
        ShowCurrentLocationView(locationVM: LocationViewModel())
    }
}
