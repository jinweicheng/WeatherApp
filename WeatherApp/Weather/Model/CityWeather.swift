
//
//  CityWeather.swift
//  WeatherApp
//
//  Created by 程金伟 on 2022/7/26.
//

import Foundation

// MARK: - CityWeather
struct CityWeather: Decodable {
    let coord: CoordItem
    let weather: [WeatherItem]
    let base: String
    let main: MainItem
    let visibility: Int
    let wind: WindItem
    let clouds: CloudsItem
    let dt: Int
    let sys: SysItem
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - CoordItem
struct CoordItem: Decodable {
    let lon, lat: Double
}

// MARK: - WeatherItem
struct WeatherItem: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon:String
}

// MARK: - MainItem
struct MainItem: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - WindItem
struct WindItem: Decodable {
    let speed: Double
    let deg: Int
}

// MARK: - CloudsItem
struct CloudsItem: Decodable {
    let all: Int
}

// MARK: - SysItem
struct SysItem: Decodable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}


