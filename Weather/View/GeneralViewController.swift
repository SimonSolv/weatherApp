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
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupViews()
        setupConstraints()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  if currentCity != nil {
            requestWeather(completion: { weather in
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
        
      //  }
    }
    
    func setupController() {
        title = "Weather"
        view.backgroundColor = .lightGray
    }
    
    func setupViews() {
        view.addSubview(tableView)
        view.addSubview(addCityView)
        view.addSubview(addButton)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
        
        addCityView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
        
        addButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(addCityView.snp.centerX)
            make.centerY.equalTo(addCityView.snp.centerY)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
    @objc private func addCityTapped() {
        print("+ tapped")
        let controller = AddCityViewController(style: .grouped)
        navigationController?.pushViewController(controller, animated: true)
    }
    
/* =55.75&lon=37.61&appid=813fe141065e9cb880c0c124702b622b&units=metric&lang=ru
    */
    private func urlComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: "-79.38"),
            URLQueryItem(name: "lon", value: "43.65"),
            URLQueryItem(name: "appid", value: "813fe141065e9cb880c0c124702b622b"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "ru"),
        ]
        return urlComponents
    }
    
    func requestWeather(completion: ((_ weather: CityWeather? ) -> Void)?) {
        let components = self.urlComponents()
        let url = components.url
        print("\(url)")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!, completionHandler: { data, responce, error in
            if let error = error {
                print(error.localizedDescription)
                completion?(nil)
                return
            }
            
            if (responce as! HTTPURLResponse).statusCode != 200 {
                print ("StstusCode = \((responce as! HTTPURLResponse).statusCode)")
                completion?(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion?(nil)
                return
            }
            
            do {
                let answer = try JSONDecoder().decode(CityWeather.self, from: data)
                completion?(answer)
                return
            } catch {
                print(error)
            }
        })
        task.resume()
    }


}

extension GeneralViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CitiesTableViewCell.identifier, for: indexPath) as! CitiesTableViewCell
        cell.city = cities[indexPath.row]
        return cell
    }
    
    
}
