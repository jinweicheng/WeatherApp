
//
//  ListViewModel.swift
//  WeatherApp
//
//  Created by 程金伟 on 2022/7/26.
//

import Foundation
import CoreLocation


// MARK: - ListViewModelDelegate
protocol ListViewModelDelegate {
    func didUpdateWeather(weather:CityWeather)
    func didFailWithError(error:Error)
}

// MARK: - ListViewModel
class ListViewModel {
    let cityList = ["Gothenburg", "Stockholm", "London", "New York","Berlin"]
    var viewModel:CityWeather?
    var api = WeatherAPI()
    var delegate:ListViewModelDelegate?
    func fetchWeather(cityName: String?) {
        guard cityName?.count != 0 else {
            return
        }
        api.delegate = self
        api.fetchWeather(cityName: cityName ?? cityList[0])
    }
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        api.delegate = self
        api.fetchWeather(latitude: latitude, longitude: longitude)
    }
}

// MARK: - extension
extension ListViewModel: WeatherAPIDelegate {
    func didUpdateWeather(weather: CityWeather) {
        self.delegate?.didUpdateWeather(weather: weather)
    }
    func didFailWithError(error: Error) {
        self.delegate?.didFailWithError(error: error)
    }
}
