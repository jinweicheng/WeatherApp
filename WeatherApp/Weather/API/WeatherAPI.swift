
//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by 程金伟 on 2022/7/26.
//

import Foundation
import CoreLocation


protocol WeatherAPIDelegate {
    func didUpdateWeather(weather:CityWeather)
    func didFailWithError(error:Error)
}

struct WeatherAPI {
    
    let apiKey = "cb9460bd4572175d0b37df1e3bdc78d7"
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?"
    var delegate:WeatherAPIDelegate?
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(baseUrl)&appid=\(apiKey)&lat=\(latitude)&lon=\(longitude)";
        performRequest(urlString: urlString);
    }
    
    func fetchWeather(cityName: String) {
        let urlString = "\(baseUrl)&appid=\(apiKey)&q=\(cityName)"
        performRequest(urlString: urlString);
    }
    
    func performRequest(urlString:String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if (error != nil) {
                    self.delegate?.didFailWithError(error:error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather: weather);
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData:Data) -> CityWeather? {
        let decoder = JSONDecoder()
        do {
            let weather = try decoder.decode(CityWeather.self, from: weatherData)
            return weather;
        }
        catch {
            self.delegate?.didFailWithError(error: error)
            return nil;
        }
    }
}

