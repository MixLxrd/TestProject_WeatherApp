//
//  DetailViewController.swift
//  TestProject_WeatherApp
//
//  Created by Mike on 02.09.2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var request: URLRequest
    
    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .white
        webView.load(request)
        webView.toAutoLayout()
        view.addSubview(webView)
        let constraints = [
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    init(request: URLRequest) {
        self.request = request
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
