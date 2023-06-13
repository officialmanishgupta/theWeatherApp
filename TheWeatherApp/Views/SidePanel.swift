//
//  SidePanel.swift
//  TheWeatherApp
//
//  Created by Manish Gupta on 6/11/23.
//

import SwiftUI

struct SidePanel: View {
    @ObservedObject var locationVM: LocationViewModel
    var body: some View {
        List {
            Section {
                ShowCurrentLocationView(locationVM: locationVM)
                Text("Location shared: \(locationVM.isLocationAccessAllowed.description)")
                Text("Units: ℉")
            } header: {
                HStack {
                    Image(systemName: "cloud.sun.fill")
                    Text("Weather information")
                }
            }
            
            
        }
        
    }
}

struct TWASidePanel_Previews: PreviewProvider {
    static var previews: some View {
        SidePanel(locationVM: LocationViewModel())
    }
}
