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
    
    var weather: CurrentWeather?
    
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
        contentView.backgroundColor = .systemBackground
        let constraints = [
            header.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            header.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
