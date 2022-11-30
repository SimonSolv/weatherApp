//
//  MainWeatherCardHeaderView.swift
//  Weather
//
//  Created by Simon Pegg on 30.11.2022.
//

import UIKit
import SnapKit

class MainWeatherCardTableHeaderView: UITableViewHeaderFooterView {

    var header = WeatherCardView()
    
    var weather: CityWeather?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        header.weather = self.weather
        setupViews()
    }
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        header.weather = self.weather
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(header)
        let constraints = [
            header.topAnchor.constraint(equalTo: contentView.topAnchor),
            header.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
