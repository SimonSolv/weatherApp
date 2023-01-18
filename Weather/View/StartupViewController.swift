//
//  StartupViewController.swift
//  Weather
//
//  Created by Simon Pegg on 16.01.2023.
//

import UIKit
import SnapKit
import MapKit

class StartupViewController: UIViewController {
    
    var determinedLocation: CLLocation?
    
    public var completion: ((_ newlocation: CLLocation? ) -> Void)?
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        return locationManager
    }()
    
//    lazy var cloud1: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage(named: "Vector")
//        view.layer.opacity = 0.5
//        return view
//    }()
//
//    lazy var cloud2: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage(named: "Vector-1")
//        view.layer.opacity = 0.5
//        return view
//    }()
//
//    lazy var cloud3: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage(named: "Vector-2")
//        view.layer.opacity = 0.5
//        return view
//    }()
    
    lazy var girl: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ambrellaGirl")
        return view
    }()
    
    lazy var useLocationButton: UIButton = {
        let btn = UIButton()
        btn.layer.backgroundColor = UIColor.orange.cgColor
        btn.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(useGeoposition), for: .touchUpInside)
        return btn
    }()

    lazy var dontUseLocationButton: UIButton = {
        let btn = UIButton()
        btn.layer.backgroundColor = UIColor.clear.cgColor
        btn.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(notUseGeoposition), for: .touchUpInside)
        return btn
    }()
    
    
//MARK: -Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.geoPositionAdded(notification:)),
                                               name: Notification.Name("showWeather"),
                                               object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupViews()
        setupConstraints()
    }
    

    private func setupViews() {
        view.layer.backgroundColor = UIColor(named: "appBackground")?.cgColor
        view.addSubview(girl)
        view.addSubview(useLocationButton)
        view.addSubview(dontUseLocationButton)
    }
    
    private func setupConstraints() {
//        cloud1.snp.makeConstraints { (make) in
//            make.height.equalTo(16)
//            make.width.equalTo(25)
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
//            make.leading.equalTo(view.snp.leading)
//        }
//
//        cloud2.snp.makeConstraints { (make) in
//            make.height.equalTo(16)
//            make.width.equalTo(25)
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
//            make.leading.equalTo(view.snp.leading)
//        }
//
//        cloud3.snp.makeConstraints { (make) in
//            make.height.equalTo(16)
//            make.width.equalTo(25)
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
//            make.leading.equalTo(view.snp.leading)
//        }
        
        girl.snp.makeConstraints { (make) in
            make.height.equalTo(180)
            make.width.equalTo(196)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(148)
            make.leading.equalTo(view.snp.leading).offset(111)
        }
        
        useLocationButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.trailing.equalTo(view.snp.trailing).offset(-17)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-163)
            make.leading.equalTo(view.snp.leading).offset(17)
        }
        
        dontUseLocationButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.trailing.equalTo(view.snp.trailing).offset(-17)
            make.top.equalTo(useLocationButton.snp.top).offset(50)
          //  make.leading.equalTo(view.snp.leading).offset(17)
        }
    }
    
    //MARK: -Buttons and other
    
    @objc func geoPositionAdded(notification: NSNotification) {
        completion?(determinedLocation)
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    @objc private func useGeoposition() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
    
    @objc private func notUseGeoposition() {
        
    }

}

extension StartupViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied, .restricted:
            DispatchQueue.main.async {
                self.present(CustomAlert(message: "Ошибка при определении местоположения", actionHandler: nil), animated: true)
            }
            print("Определение локации невозможно")
        case .notDetermined:
            print("Определение локации не запрошено")
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            self.determinedLocation = location
            NotificationCenter.default.post(name: Notification.Name("showWeather"), object: nil)
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Failed to get location premission")
    }
}
