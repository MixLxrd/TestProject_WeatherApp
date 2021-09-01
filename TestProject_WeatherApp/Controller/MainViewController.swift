//
//  MainViewController.swift
//  TestProject_WeatherApp
//
//  Created by Mike on 25.08.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private var weatherTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
    }

}

extension MainViewController {
    private func setupLayout() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
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
