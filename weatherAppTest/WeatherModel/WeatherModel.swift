//
//  WeatherModel.swift
//  weatherAppTest
//
//  Created by andres castro jaquez on 1/16/25.
//

import Foundation

// MARK: - Weather Response Model
struct WeatherResponse: Codable {
    let location: Location
    let current: Current
}

// MARK: - Current
struct Current: Codable {

    let tempC, tempF: Double
    let condition: Condition
    let humidity: Int
    let feelslikeC, feelslikeF: Double
    let uv: Double

    enum CodingKeys: String, CodingKey {

        case tempC = "temp_c"
        case tempF = "temp_f"
        case condition
        case humidity
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case uv
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String
    let code: Int
}

// MARK: - Location
struct Location: Codable {
    let name, region, country: String
    let lat, lon: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}
