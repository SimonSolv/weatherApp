//
//  AddCityViewController.swift
//  Weather
//
//  Created by Simon Pegg on 27.11.2022.
//

import UIKit

class AddCityViewController: UITableViewController, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        requestGeo(city: searchController.searchBar.text!, completion: { data in
            guard let data = data else {
                let city = City(name: "ERROR: No cities found", lat: 0, lon: 0, country: "none")
                var answer: [City] = []
                answer.append(city)
                self.cities = answer
                return
            }
            
            DispatchQueue.main.async {
                self.cities = data
                self.tableView.reloadData()
            }
        })
        
    }
    
    var cities: [City] = []
    var newCity: City?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: LifeCycle
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        // Custom initialization
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Добавить город"
        view.backgroundColor = .systemGray6
        tableView.register(CitiesTableViewCell.self, forCellReuseIdentifier: CitiesTableViewCell.identifier)

        navigationItem.searchController = searchController
        searchController.isActive = true
      //  searchController.disablesAutomaticKeyboardDismissal = true
        //searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    private func urlComponents(city: String) -> URLComponents {
        let limit = 5
        let cityName = city
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/geo/1.0/direct"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: "\(cityName)"),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "appid", value: "813fe141065e9cb880c0c124702b622b"),
        ]
        return urlComponents
    }
    
    func requestGeo(city: String, completion: ((_ cities: [City]? ) -> Void)?) {
        let components = self.urlComponents(city: city)
        let url = components.url
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
                let answer = try JSONDecoder().decode([City].self, from: data)
                completion?(answer)
                return
            } catch {
                print(error)
            }
        })
        task.resume()
    }
    
    // MARK: Table view setup
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CitiesTableViewCell.identifier, for: indexPath) as! CitiesTableViewCell
        
        cell.city = cities[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.newCity = cities[indexPath.row]
        print("Selected \(newCity?.name!)")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let share = UIActivityViewController(activityItems: [jokes[indexPath.section].text], applicationActivities: nil)
//        present(share, animated: true)
//    }
}

