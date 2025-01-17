//
//  ApiService.swift
//  weatherAppTest
//
//  Created by andres castro jaquez on 1/16/25.
//

import Foundation

protocol NetworkService {
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case other(Error)
}

class WeatherAPIService: NetworkService {
    private let apiKey = "d674765f78494ed1920172719251501"
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        //create url
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)&aqi=no".replacingOccurrences(of:" ", with: "%20")
        print(urlString)
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            //handling error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                //handling error
                completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                return
            }
            
            do {
                //pass data
                let decodedResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
