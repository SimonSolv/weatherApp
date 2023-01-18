//
//  GeneralViewController.swift
//  Weather
//
//  Created by Simon Pegg on 27.11.2022.
//

import UIKit
import SnapKit
import MapKit

class GeneralViewController: UIViewController {
    
    var cities: [City] = []
    
    var currentCity: City?
    
    var currentLocation: CLLocation?
    
    var weather: CurrentWeather?
    
    var hourlyWeather: [HourWeather]?
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.delegate = self
        table.dataSource = self
        table.register(HourlyWeatherTableViewCell.self, forCellReuseIdentifier: HourlyWeatherTableViewCell.identifier)
        table.register(MainWeatherCardTableHeaderView.self, forHeaderFooterViewReuseIdentifier: WeatherCardView.identifier)
        table.backgroundColor = .tertiarySystemBackground
        return table
        
    }()
    
    lazy var addCityView: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = .boldSystemFont(ofSize: 100)
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addCityTapped), for: .touchUpInside)
        button.layer.backgroundColor = UIColor.green.cgColor //Убрать при релизе
        return button
    }()
    
    let myRefreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshTable(sender:)), for: .valueChanged)
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupViews()
        setupConstraints()
        checkCity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.upadteWeatherNotified(notification:)),
                                               name: Notification.Name("needUpdateWeather"),
                                               object: nil)
        updateWeather()
        checkCity()
    }
    
    func updateWeather() {

        guard let city = currentCity else {
            print("CurrentCity is NIL")
            return
        }
        requestHourWeather(city: currentCity!.Key, completion: { weather in
            guard let weather = weather else {
                print("Coudnt find Hourly weather data")
                return
            }
            self.hourlyWeather = weather
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        requestDayWeather(city: city.Key, completion: { weather in
            guard let weather = weather else {
                print("Coudnt find weather data")
                return
            }
            self.weather = weather.first
            DispatchQueue.main.async {
                self.title = "\(self.currentCity?.LocalizedName ?? "Name Error"), \(self.currentCity?.Country.LocalizedName ?? "Город не выбран")"
                self.tableView.reloadData()
            }
        })
        

    }
    
    func checkCity() {
        if currentLocation != nil {
            requestCityKeyByGeoposition(position: self.currentLocation!, completion: {city in
                self.currentCity = city
                NotificationCenter.default.post(name: Notification.Name("needUpdateWeather"), object: nil)
            })
        }
        if currentCity != nil {
            NotificationCenter.default.post(name: Notification.Name("needUpdateWeather"), object: nil)
        }
    }
    
    @objc func upadteWeatherNotified(notification: NSNotification) {
        updateWeather()
    }
    
    @objc func refreshTable(sender: UIRefreshControl) {
        self.updateWeather()
        sender.endRefreshing()
    }
    
    private func setupController() {
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        view.backgroundColor = .systemBackground
        setUpMenuButton()
        if currentLocation != nil {
            print("UpdatingWeather")
            updateWeather()
        } else {
            if currentCity != nil {
                title = "\(currentCity!.LocalizedName), \(currentCity!.Country.LocalizedName)"
            } else {
                title = "Выберите город"
            }
        }

    }
    
    func setUpMenuButton() {
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 26)
        menuBtn.setImage(UIImage(named:"geo2"), for: .normal)
        menuBtn.tintColor = .black
        menuBtn.addTarget(self, action: #selector(addCityTapped), for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 20)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 26)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = menuBarItem
    }
    
    private func setupViews() {
        tableView.refreshControl = myRefreshControl
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.addSubview(tableView)

    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }

    }
    
    @objc private func addCityTapped() {
        let controller = AddCityViewController(style: .grouped)
        controller.completion = { [weak self] city in
            self?.currentCity = city!
            self?.title = self!.currentCity!.LocalizedName + ", " + self!.currentCity!.Country.LocalizedName
            self?.updateWeather()
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func showDetailedViewController() {
        let vc = UIViewController(nibName: nil, bundle: nil)
        vc.title = "Detailed"
        vc.view.backgroundColor = .green
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension GeneralViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherTableViewCell.identifier, for: indexPath) as! HourlyWeatherTableViewCell
            cell.cellsSource = hourlyWeather
            cell.delegate = self
            return cell
        } else {
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = MainWeatherCardTableHeaderView(reuseIdentifier: "Header")
        if self.weather != nil {
            view.header.weather = weather
        }
        return view
    }
    
    
}
