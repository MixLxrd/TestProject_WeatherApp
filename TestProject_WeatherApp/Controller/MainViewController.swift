//
//  MainViewController.swift
//  TestProject_WeatherApp
//
//  Created by Mike on 25.08.2021.
//

import UIKit
import CoreLocation
import WebKit

class MainViewController: UIViewController {
    
    var cityWeather: CityWeather?
    
    var cities: [CityWeather] = [] {
        didSet {
            weatherTableView.reloadData()
        }
    }
    
    var citiesForTableView: Dictionary<String,String> = [:]
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    let networkService = NetworkSevice()
    
    private lazy var weatherTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: String(describing: CityTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    
    func fetchCityFromSearchBar(_ searchText: String) {
        getCoordinateFrom(address: searchText) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            DispatchQueue.main.async {
                print(coordinate)
                
                let newUrl = "https://api.weather.yandex.ru/v2/forecast?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&extra=true&lang=en_US"
                self.networkService.request(
                    url: newUrl,
                    response:
                        {   response in
                            guard let result = response else { return }
                            let url = URL(string: result.info.url)
                            let request = URLRequest(url: url!)
                            
                            let vc = DetailViewController(request: request)
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        })
            }
            
        }
        
        
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        citiesForTableView["moscow"] = "lat=55.75396&lon=37.620393"
        citiesForTableView["perm"] = "lat=58.000000&lon=56.316666"
        citiesForTableView["ufa"] = "lat=54.733334&lon=56.000000"
        citiesForTableView["arkhangelsk"] = "lat=64.539304&lon=40.518735"
        citiesForTableView["ekaterinburg"] = "lat=56.838002&lon=60.597295"
        citiesForTableView["kiev"] = "lat=50.402395&lon=30.532690"
        citiesForTableView["omsk"] = "lat=54.989342&lon=73.368212"
        citiesForTableView["vladivostok"] = "lat=43.134019&lon=131.928379"
        citiesForTableView["krasnodar"] = "lat=45.023877&lon=38.970157"
        citiesForTableView["murmansk"] = "lat=68.96956299999999&lon=33.07454"
        
        for city in citiesForTableView {
            let newUrl = "https://api.weather.yandex.ru/v2/forecast?\(city.value)&extra=true&lang=en_US"
            networkService.request(
                url: newUrl,
                response:
                    {   response in
                        guard let result = response else { return }
                        self.cityWeather = result
                        self.cities.append(result)
                    })
        }
        
    }
}

extension MainViewController {
    private func setupLayout() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
        
        title = "Weather"
        view.addSubview(weatherTableView)
        let constraints = [
            weatherTableView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            weatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CityTableViewCell.self), for: indexPath) as! CityTableViewCell
        
        cell.nameCityTextLabel.text = String(describing: cities[indexPath.row].geoObject.locality.name)
        cell.temperatureTextLabel.text = String(describing: cities[indexPath.row].fact.temp) + "'C"
        cell.conditionTextLabel.text = String(describing: cities[indexPath.row].fact.condition)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let url = URL(string: cities[indexPath.row].info.url)
        let request = URLRequest(url: url!)
        
        let vc = DetailViewController(request: request)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchBar = searchController.searchBar
        fetchCityFromSearchBar(searchBar.text!.lowercased())
    }
}


