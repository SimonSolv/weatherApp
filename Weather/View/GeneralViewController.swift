//
//  GeneralViewController.swift
//  Weather
//
//  Created by Simon Pegg on 27.11.2022.
//

import UIKit
import SnapKit

class GeneralViewController: UIViewController {
    
    var cities: [City] = []
    
    var currentCity: City?
    
    var weather: CityWeather?
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.delegate = self
        table.dataSource = self
        table.register(CitiesTableViewCell.self, forCellReuseIdentifier: CitiesTableViewCell.identifier)
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
        button.layer.backgroundColor = UIColor.green.cgColor
        return button
    }()
    
    let myRefreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshTable(sender:)), for: .valueChanged)
        return control
    }()
    
    lazy var weatherCardView = WeatherCardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupViews()
        setupConstraints()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateWeather()
        setupViews()
        setupConstraints()
        
    }
    
    func updateWeather() {
        guard let city = currentCity else {
            print("CurrentCity is NIL")
            return
        }
        requestDayWeather(city: city, completion: { weather in
            guard let weather = weather else {
                print("Coudnt fint weather data")
                return
            }
            self.weather = weather
            print(weather)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    @objc func refreshTable(sender: UIRefreshControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        sender.endRefreshing()
    }
    
    private func setupController() {
        title = "Weather"
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCityTapped))
        navigationItem.rightBarButtonItem = addItem
        view.backgroundColor = .lightGray
    }
    
    private func setupViews() {
        tableView.refreshControl = myRefreshControl
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
        print("+ tapped")
        let controller = AddCityViewController(style: .grouped)
        controller.completion = { [weak self] city in
            self?.currentCity = city!
            self?.updateWeather()
        }
        navigationController?.pushViewController(controller, animated: true)
    }

}

extension GeneralViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CitiesTableViewCell.identifier, for: indexPath) as! CitiesTableViewCell
        cell.city = cities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = MainWeatherCardTableHeaderView(reuseIdentifier: "Header")
        if self.weather != nil {
            view.header.weather = weather
        }
        return view
    }
    
    
}
