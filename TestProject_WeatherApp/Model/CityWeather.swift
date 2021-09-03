// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cityWeather = try? newJSONDecoder().decode(CityWeather.self, from: jsonData)

import Foundation

// MARK: - CityWeather
struct CityWeather: Codable {
    let info: Info
    let fact: Fact
    let geoObject: GeoObject
    
    enum CodingKeys: String, CodingKey {
        case info
        case fact
        case geoObject = "geo_object"
    }
}

struct Fact: Codable {
    let temp: Int
    let feelsLike: Int
    let condition: String
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case condition
    }
}

struct Info: Codable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}

// MARK: - GeoObject
struct GeoObject: Codable {
    let locality: Country
    
    enum CodingKeys: String, CodingKey {
        case locality
    }
}

// MARK: - Country
struct Country: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
}
