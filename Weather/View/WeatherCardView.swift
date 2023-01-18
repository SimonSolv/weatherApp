//
//  WeatherCard.swift
//  Weather
//
//  Created by Simon Pegg on 28.11.2022.
//

import UIKit
import SnapKit

class WeatherCardView: UIView{
    
    static let identifier = "WeatherHeaderCardView"
    
    lazy var circleRadius: Float = Float(self.bounds.width / 2 * 0.8)
    
    var tMin: String = "-"
    var tmax: String = "-"
    var cityName: String = "-"
    var currentTemp: String = "-"
    var sunRiseTimeString: String = "-"
    var sunSetTimeString: String = "-"
    
    var weather: CurrentWeather? {
        didSet {
            setupWeatherDescriptionView()
        }
    }
    
    lazy var weatherDescriptionLabel = MyLabel(labelType: .secondaryText, color: .white)
    
    lazy var tminTmax = MyLabel(labelType: .secondaryText, color: .white)
    
    lazy var currentTempLabel = MyLabel(labelType: .mainText, color: .white)
    
    lazy var cityNameLabel = MyLabel(labelType: .title, color: .white)
    
    lazy var sunRiseLabel = MyLabel(labelType: .secondaryText, color: .white)
    
    lazy var sunSetLabel = MyLabel(labelType: .secondaryText, color: .white)
    
    lazy var cloudnessImage = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 25, height: 16)))
    
    lazy var cloudnesslabel = MyLabel(labelType: .secondaryText, color: .white)
    
    lazy var windImage = UIImageView()
    
    lazy var windLabel = MyLabel(labelType: .secondaryText, color: .white)
    
    lazy var perceptionImage = UIImageView()
    
    lazy var perceptionLabel = MyLabel(labelType: LabelType.secondaryText, color: .white)
    
    lazy var timeDateLabel = MyLabel(labelType: .secondaryText, color: .yellow)
    
    lazy var cloudsStack = UIStackView(arrangedSubviews: [
        self.cloudnessImage,
        self.cloudnesslabel
    ])
    
    lazy var windStack = UIStackView(arrangedSubviews: [
        self.windImage,
        self.windLabel
    ])
    
    lazy var perceptionStack = UIStackView(arrangedSubviews: [
        self.perceptionImage,
        self.perceptionLabel
    ])
    
    lazy var weatherDescriptionView = UIStackView(arrangedSubviews: [
        self.cloudsStack,
        self.windStack,
        self.perceptionStack
    ])
    
    lazy var labelsView = UIStackView(arrangedSubviews: [
        self.tminTmax,
        self.currentTempLabel,
        self.weatherDescriptionLabel,
        self.weatherDescriptionView,
        self.timeDateLabel
    ])
    
    override func draw(_ rect: CGRect) {
        let view = UIBezierPath(arcCenter: CGPoint(x: bounds.width/2, y: bounds.maxY - 60) , radius: CGFloat(circleRadius), startAngle: 0, endAngle: CGFloat.pi, clockwise: false)
        view.lineWidth = 3
        #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).setStroke()
        view.stroke()
    }

    lazy var sunRiseImage: UIImageView = {
        let oldImg = UIImage(named: "sunRise")
        let img = oldImg!.withTintColor(UIColor.yellow)
        let view = UIImageView(image: img)
        return view
    }()
    
    lazy var sunSetImage: UIImageView = {
        let oldImg = UIImage(named: "sunSet")
        let img = oldImg!.withTintColor(UIColor.yellow)
        let view = UIImageView(image: img)
        return view
    }()
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "appBackground")
        layer.cornerRadius = 5
        clipsToBounds = true
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        labelsView.translatesAutoresizingMaskIntoConstraints = false
        labelsView.axis = .vertical
        labelsView.distribution = .equalSpacing
        
        windStack.spacing = 5
        cloudsStack.spacing = 5
        perceptionStack.spacing = 5
        
        weatherDescriptionLabel.numberOfLines = 0
        
        weatherDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        weatherDescriptionView.axis = .horizontal
        weatherDescriptionView.distribution = .equalSpacing
        
        addSubview(labelsView)
        addSubview(sunSetImage)
        addSubview(sunRiseImage)
        addSubview(sunSetLabel)
        addSubview(sunRiseLabel)

    }
    
    private func setupWeatherDescriptionView() {
        let cloud = UIImage(named: "CloudsAndSun")
        self.cloudnessImage.image = cloud
        let wind = UIImage(named: "windWhite")
        self.windImage.image = wind
        let rain = UIImage(named: "rain")
        self.perceptionImage.image = rain
        
        if let text = self.weather?.wind {
            self.windLabel.text = "\(Int(text.speed.metric.value)) \(text.speed.metric.unit)"
        } else {
            self.windLabel.text = "-"
        }
        
        if let text = self.weather?.description {
            self.weatherDescriptionLabel.text = "\(text)"
        } else {
            self.weatherDescriptionLabel.text = "-"
        }
        
        if let text = self.weather?.precipitation {
            self.perceptionLabel.text = "\(text.metric.value) \(text.metric.unit)"
        }
        else {
            self.perceptionLabel.text = "-"
        }
        
        if let text = self.weather?.clouds {
            self.cloudnesslabel.text = "\(text)"
        } else {
            self.cloudnesslabel.text = "-"
        }
        if let text = self.weather?.temp {
            self.currentTemp = "\(Int(text.metric.value))°\(text.metric.unit)"
        }
        if let text = self.weather?.minMaxTemp {
            self.tmax = "\(Int(text.past12Hours.max.metric.value))°\(text.past12Hours.max.metric.unit)"
            self.tMin = "\(Int(text.past12Hours.min.metric.value))°\(text.past12Hours.min.metric.unit)"
        }

        self.tminTmax.text = self.tMin + "/" + self.tmax
        self.currentTempLabel.text = self.currentTemp
      //  self.cityNameLabel.text = self.cityName
        self.sunSetLabel.text = self.sunSetTimeString
        self.sunRiseLabel.text = self.sunRiseTimeString
      //  self.cityNameLabel.text = self.cityName
        self.timeDateLabel.textColor = .yellow
        if let text = self.weather?.time {
            self.timeDateLabel.text = (self.weather?.localTime ?? "0000") + String(describing: self.weather?.isDayTime)
//            self.timeDateLabel.text = timeToString(time: text, type: .dateTime, timeZone: nil) ?? "-"
        }

    }
    
    private func setValues() {
        tminTmax.text = self.tMin + "/" + self.tmax
        currentTempLabel.text = self.currentTemp
        cityNameLabel.text = self.cityName
        sunSetLabel.text = self.sunSetTimeString
        sunRiseLabel.text = self.sunRiseTimeString
    }
    
    private func setupConstraints() {
        
        labelsView.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(snp.top).offset(40)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).offset(-150)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
        }

        self.snp.makeConstraints{ (make) in
            make.height.equalTo(230)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
        }

        cloudnessImage.snp.makeConstraints { (make) in
            make.height.equalTo(16)
            make.width.equalTo(25)
        }
        
        perceptionImage.snp.makeConstraints { (make) in
            make.height.equalTo(16)
            make.width.equalTo(25)
        }
        
        windImage.snp.makeConstraints { (make) in
            make.height.equalTo(16)
            make.width.equalTo(25)
        }
        
        sunSetImage.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-35)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-28)
            make.height.equalTo(17)
            make.width.equalTo(17)
        }

        sunRiseLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-15)
            make.centerX.equalTo(sunRiseImage.snp.centerX)
            make.height.equalTo(17)
            make.width.equalTo(50)
        }

        sunSetLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-15)
            make.centerX.equalTo(sunSetImage.snp.centerX)
            make.height.equalTo(17)
            make.width.equalTo(50)
        }
        
        sunRiseImage.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-35)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(28)
            make.height.equalTo(17)
            make.width.equalTo(17)
        }


    }

}
