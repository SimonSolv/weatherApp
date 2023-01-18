//
//  HourlyWeatherCollectionViewCell.swift
//  Weather
//
//  Created by Simon Pegg on 04.12.2022.
//

import UIKit
import SnapKit
import Kingfisher

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    static let identifier = "HourlyWeatherCell"
    
    var hourlyWeather: HourWeather? {
        didSet {
            if self.hourlyWeather != nil {
                var iconNum = ""
                if self.hourlyWeather!.icon < 10 {
                    iconNum = "0\(self.hourlyWeather!.icon)"
                } else {
                    iconNum = "\(self.hourlyWeather!.icon)"
                }
                let imgUrl = URL(string: "https://developer.accuweather.com/sites/default/files/\(iconNum)-s.png")
                
                weatherImage.kf.setImage(with: imgUrl)
                timeLabel.text = timeToString(time: hourlyWeather!.time, type: .time, timeZone: nil)!
                weatherLabel.text = "\(Int(hourlyWeather!.temp.value))°"
            } else {
                setupValues()
            }
        }
    }
    
    lazy var timeLabel = MyLabel(labelType: .smallText, color: .black)
    
    lazy var weatherLabel = MyLabel(labelType: .smallText, color: .black)
    
    lazy var weatherImage = UIImageView()
    
    
    
    lazy var weatherView = UIStackView(arrangedSubviews: [
        self.timeLabel,
        self.weatherImage,
        self.weatherLabel
    ])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupView()
        setupValues()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
        setupView()
        setupValues()
    }
    
    private func setupCell() {
        contentView.layer.cornerRadius = 21
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(named: "appBackground")?.cgColor
    }
    
    private func setupView() {
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        weatherView.axis = .vertical
        weatherView.distribution = .equalSpacing
        contentView.addSubview(weatherView)
        weatherImage.contentMode = .scaleAspectFill
        weatherView.snp.makeConstraints {(make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }
        
        weatherImage.snp.makeConstraints {(make) in
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
    }
    
    private func setupValues() {
        if self.hourlyWeather == nil {
            self.timeLabel.text = "-"
            self.weatherLabel.text = "-"
            self.weatherImage.image = UIImage(named: "clouds")
        }
    }
    
    private func setWeatherImage(code: Int?) {
        guard (code != nil) else {
            print ("Cannot get code value")
            return
        }
        if code! >= 200 && code! < 300 {
            weatherImage.image = UIImage(named: "thunder")
        } else if code! >= 300 && code! < 500 {
            weatherImage.image = UIImage(named: "clouds")
        } else if code! >= 500 && code! < 600 {
            weatherImage.image = UIImage(named: "rain")
        } else if code! >= 600 && code! < 700 {
            weatherImage.image = UIImage(named: "Frame-7")
        } else if code! >= 700 && code! < 800 {
            weatherImage.image = UIImage(named: "CloudsAndSun")
        } else if code! == 800 {
            weatherImage.image = UIImage(named: "Frame")
        } else if code! >= 801 && code! < 900 {
            weatherImage.image = UIImage(named: "clouds")
        }
        
        
    }
}
