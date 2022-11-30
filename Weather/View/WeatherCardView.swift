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
    
    var weather: CityWeather? {
        didSet {
            decodeWeather()
        }
    }
    
    lazy var tminTmax = MyLabel(labelType: .secondaryText)
    
    lazy var currentTempLabel = MyLabel(labelType: .mainText)
    
    lazy var cityNameLabel = MyLabel(labelType: .title)
    
    lazy var sunRiseLabel = MyLabel(labelType: .secondaryText)
    
    lazy var sunSetLabel = MyLabel(labelType: .secondaryText)
    
    lazy var labelsView = UIStackView(arrangedSubviews: [
        self.cityNameLabel,
        self.tminTmax,
        self.currentTempLabel
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
//        if weather == nil {
//            setValues()
//        }
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
        labelsView.spacing = 10
        
        addSubview(labelsView)
        
        addSubview(sunSetImage)
        addSubview(sunRiseImage)
        addSubview(sunSetLabel)
        addSubview(sunRiseLabel)




        //addSubview(addButton)
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
            make.centerY.equalTo(snp.centerY)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).offset(30)
            make.height.equalTo(300)
        }

        self.snp.makeConstraints{ (make) in
            make.bottom.equalTo(labelsView.snp.bottom)
        }
        
        sunSetImage.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-35)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(28)
            make.height.equalTo(17)
            make.width.equalTo(17)
        }
        
        sunRiseImage.snp.makeConstraints { (make) in
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


    }
    
    private func addPlusMinus(temp: Float) -> String {
        if  temp > 0 {
            return "+\(Int(temp))°"
        } else if temp < 0 {
            return "-\(Int(temp))°"
        } else {
            return "\(Int(temp))°"
        }
    }
    
    func timeToString(time: Int) -> String? {
        let date = Date(timeIntervalSince1970: Double(time))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
      //  dateFormatter.dateStyle = DateFormatter.Style.long //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }


    private func decodeWeather() {
        if weather?.main.temp != nil {
            self.currentTemp = addPlusMinus(temp: weather!.main.temp)
            print(self.currentTemp)
        }
        if weather?.main.temp_max != nil {
            self.tmax = addPlusMinus(temp: weather!.main.temp_max)
        }
        if weather?.main.temp_min != nil {
            self.tMin = addPlusMinus(temp: weather!.main.temp_min)
        }
        if weather?.sys?.sunrise != nil {
            self.sunRiseTimeString = timeToString(time: weather!.sys!.sunrise!) ?? "-"
            print(sunRiseTimeString)
        }
        if weather?.sys?.sunset != nil {
            self.sunSetTimeString = timeToString(time: weather!.sys!.sunset!) ?? "-"
        }
        if weather?.name != nil {
            self.cityName = weather!.name ?? "No data"
        }
        self.tminTmax.text = self.tMin + "/" + self.tmax
        self.currentTempLabel.text = self.currentTemp
        self.cityNameLabel.text = self.cityName
        self.sunSetLabel.text = self.sunSetTimeString
        self.sunRiseLabel.text = self.sunRiseTimeString
        self.cityNameLabel.text = self.cityName

    }
    


}
