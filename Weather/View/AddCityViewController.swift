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
                print("Cities not found")
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
        tableView.layer.cornerRadius = 5
        tableView.clipsToBounds = true
        self.navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .systemGray6
        tableView.register(CitiesTableViewCell.self, forCellReuseIdentifier: CitiesTableViewCell.identifier)

        navigationItem.searchController = searchController
        searchController.isActive = true
      //  searchController.disablesAutomaticKeyboardDismissal = true
        //searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.searchController.isActive = true
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    public var completion: ((City?) -> Void)?

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
        completion?(cities[indexPath.row])
        self.navigationController?.popToRootViewController(animated: true)
    }

}

extension AddCityViewController: UISearchControllerDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
}
