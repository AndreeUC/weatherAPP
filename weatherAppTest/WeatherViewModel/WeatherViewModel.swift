//
//  WeatherViewModel.swift
//  weatherAppTest
//
//  Created by andres castro jaquez on 1/16/25.
//

import Foundation
import SwiftUI

class WeatherViewModel: ObservableObject {
    // MARK: - Properties
        @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var city: String = ""
    @Published var showCard = false
    @Published var showDetails = false

    
    private let networkService: NetworkService

        // Dependency Injection through the initializer
        init(networkService: NetworkService) {
            self.networkService = networkService
        }

        // Fetch weather data for selected city city
        func fetchWeather() {
            guard !city.isEmpty else {
                errorMessage = "Please enter a city."
                return
            }


            
            isLoading = true
            networkService.fetchWeather(for: city) { [weak self] result in
                DispatchQueue.main.async {
                        self?.isLoading = false
                    switch result {
                    case .success(let weatherData):
                        // Save the entered city to UserDefaults
                        UserDefaults.standard.set(self?.city, forKey: "savedCity")
                        withAnimation(.easeInOut(duration: 0.5)){
                            self?.showDetails = false
                            self?.showCard = true
                            self?.weather = weatherData
                        }
                           
                    case .failure(let error):
                        self?.showCard = false
                        self?.weather = nil
                        self?.errorMessage = error.localizedDescription
                    }
                }
            }
        }

        // Load the city from UserDefaults when the app starts
        func loadSavedCity() {
            if let savedCity = UserDefaults.standard.string(forKey: "savedCity") {
                city = savedCity
                fetchWeather() // Automatically fetch weather if a city was stored
            }
        }
}


#Preview {
    WeatherView(viewModel: WeatherViewModel(networkService: WeatherAPIService()))
}
