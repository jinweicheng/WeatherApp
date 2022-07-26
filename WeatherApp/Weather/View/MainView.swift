//
//  MainView.swift
//  WeatherApp
//
//  Created by 程金伟 on 2022/7/26.
//

import UIKit

class MainView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 50
        return tableView
    }()
    
    lazy var weatherView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 250))
        view.layer.borderWidth = 1.0
        view.layer.borderColor = CGColor.init(red: 200, green: 200, blue: 200, alpha: 1.0)
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(cityLabel)
        view.addSubview(weatherLabel)
        return view
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 60, width: 375, height: 40))
        label.text = "country"
        label.textAlignment = .center
        return label
    }()
    
    lazy var weatherLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 100, width: 375, height: 40))
        label.text = "broken clouds"
        label.textAlignment = .center
        return label
    }()
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 150, y: 150, width: 60, height: 60))
        imageView.backgroundColor = .white
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        addSubview(weatherView)
        addSubview(tableView)
        setUpConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        tableView.topAnchor.constraint(equalTo: topAnchor, constant: 250).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func setUpViews(weather: CityWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = "\(weather.sys.country):\(weather.name)"
            self.weatherLabel.text = weather.weather[0].description
            // http://openweathermap.org/img/wn/10d@2x.png
            let url = URL(string: "https://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png")
            let data = try! Data(contentsOf: url!)
            let newImage = UIImage(data: data)
            self.imageView.image = newImage
            
        }
    }

}
