//
//  MainCoordinator.swift
//  TheWeatherApp
//
//  Created by Manish Gupta on 6/11/23.
//

import Foundation
import UIKit
import SwiftUI

protocol CoordinatorProtocol: AnyObject {
    func start()
}

class MainCoordinator: CoordinatorProtocol {
    let window: UIWindow
    var hasLocationAccess: Bool = false
    var locationManager: LocationPermissionManager = LocationPermissionManager.sharedInstance
    var locationVM: LocationViewModel?
    
    init(window: UIWindow) {
        self.window = window
        
        initialSetup()
    }
    
    func initialSetup() {
        locationVM = locationManager.locationVM
        locationManager.locationVM.checkForLocationAccess()
    }
    
    func start() {
        window.rootViewController =
        UIHostingController(rootView:
                                MainPage(locationVM: locationManager.locationVM))
    }
}
