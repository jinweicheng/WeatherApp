
//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by 程金伟 on 2022/7/26.
//

import Foundation
import CoreLocation

// MARK: - ListViewModelDelegate
protocol LocationViewModelDelegate {
    func didUpdateLocation(coord:CLLocationCoordinate2D)
    func didFailLocationWithError(error:Error)
}

// MARK: - LocationViewModel
class LocationViewModel: NSObject {
    var locationManager = CLLocationManager();
    var lat: CLLocationDegrees = 0.0
    var lon: CLLocationDegrees = 0.0
    var delegate:LocationViewModelDelegate?
    func requestLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation();
            lat = location.coordinate.latitude;
            lon = location.coordinate.longitude;
            self.delegate?.didUpdateLocation(coord: location.coordinate)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.delegate?.didFailLocationWithError(error: error)
    }
}
