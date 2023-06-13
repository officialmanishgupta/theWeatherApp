//
//  ViewController.swift
//  TheWeatherApp
//
//  Created by Manish Gupta on 6/9/23.
//

import UIKit
import CoreLocation
import SwiftUI

class ViewController: UIViewController {
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        view.backgroundColor = .red
    }
    
    @IBAction func takeToWeatherPage(_ sender: Any) {
        let vc = UIHostingController(rootView: MainPage(locationVM: LocationViewModel()))
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("A change has occurred")
    }
}
