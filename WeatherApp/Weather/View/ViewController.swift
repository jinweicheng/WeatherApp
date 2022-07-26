//
//  ViewController.swift
//  WeatherApp
//
//  Created by 程金伟 on 2022/7/26.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var listVM = ListViewModel()
    var locationVM = LocationViewModel()
    var mainView = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // list
        listVM.delegate = self
        // location
        locationVM.requestLocation()
        locationVM.delegate = self
        // view
        setupMainView()
        setUpTableView()
        print(UIApplication.shared.windows[0].screen.bounds)
    }
    
    private func setupMainView() {
        view.backgroundColor = .white
        view = mainView
    }
    
    private func setUpTableView() {
        mainView.tableView.register(CityTableCell.self, forCellReuseIdentifier: CityTableCell.cellIdentifier)
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource,UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVM.cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableCell.cellIdentifier, for: indexPath)
        guard let cityCell = cell as? CityTableCell else {
            fatalError("Could not dequeue a cell")
        }
        cityCell.nameLabel.text = listVM.cityList[indexPath.row]
        return cityCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let citySelected = listVM.cityList[indexPath.row]
        print("didSelectRowAt",citySelected)
        listVM.fetchWeather(cityName: citySelected)
    }
}

// MARK: - ListViewModelDelegate
extension ViewController: ListViewModelDelegate {
    func didUpdateWeather(weather: CityWeather) {
        mainView.setUpViews(weather: weather)
    }
    
    func didFailWithError(error: Error) {

    }
}

extension ViewController: LocationViewModelDelegate {
    func didUpdateLocation(coord: CLLocationCoordinate2D) {
        listVM.fetchWeather(latitude: coord.latitude, longitude: coord.longitude)
    }
    
    func didFailLocationWithError(error:Error) {
        listVM.fetchWeather(cityName: "")
    }
}

