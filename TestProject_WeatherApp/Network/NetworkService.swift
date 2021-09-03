//
//  NetworkService.swift
//  TestProject_WeatherApp
//
//  Created by Mike on 01.09.2021.
//

import Foundation
import Alamofire

//X-Yandex-API-Key - 8816747c-6c5e-4dff-a92c-175de40338a3
//https://api.weather.yandex.ru/v2/informers?lat=55.75396&lon=37.620393&lang=ru_RU
//https://api.weather.yandex.ru/v2/forecast?lat=55.75396&lon=37.620393&extra=true
//second X-Yandex-API-Key - a5cb6948-25ab-4b58-bbd7-1f42f73ff1d6


class NetworkSevice {
    
    var cities: [CityWeather]?
    
    func request(url: String, response: @escaping (CityWeather?) -> Void) {
        let headers: HTTPHeaders = ["X-Yandex-API-Key": "a5cb6948-25ab-4b58-bbd7-1f42f73ff1d6"]
        AF.request(url, headers: headers).responseDecodable(of: CityWeather.self) { (result) in
          guard let cityWeather = result.value else { return }
            self.cities?.append(cityWeather)
            response(cityWeather)
        }
    }
}
