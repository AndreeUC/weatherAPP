//
//  ContentView.swift
//  weatherAppTest
//
//  Created by andres castro jaquez on 1/16/25.
//

import SwiftUI

struct WeatherView: View {
    // MARK: - Properties
    
    @StateObject private var weatherViewModel = WeatherViewModel(networkService: WeatherAPIService())

    // Add an initializer
    init(viewModel: WeatherViewModel = WeatherViewModel(networkService: WeatherAPIService())) {
           _weatherViewModel = StateObject(wrappedValue: viewModel)
       }
    
    // MARK: - Body
    var body: some View {
            VStack (spacing: 10){
                // create the search component
                SearchBar(city: $weatherViewModel.city) {
                    weatherViewModel.showDetails = false
                        weatherViewModel.fetchWeather() // Trigger fetch when search is initiated
                             }
                // Display error if no city is selected
                if weatherViewModel.weather == nil && weatherViewModel.city.isEmpty {
                                 Text("No city selected")
                                     .font(.title)
                                     .bold()
                                     .padding()
                                     .padding(.top, 150)
                                Text("Please search for a city.")
                }
                
                if weatherViewModel.isLoading {
                    //show loading image while getting data
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }else if weatherViewModel.showCard{
                    //show cityCard, user can tap it to display more details
                        if let weather = weatherViewModel.weather {
                            CityCardView(weather: weather)
                                .onTapGesture {
                                    withAnimation(.easeIn(duration: 0.5)){
                                        weatherViewModel.showCard = false
                                        weatherViewModel.showDetails = true
                                    }
                                }
                        }
                }
                else if let weather = weatherViewModel.weather {
                    //show details if user tabs on cityCard
                    if weatherViewModel.showDetails{
                        WeatherDetailsView(weather: weather)
                    }
                } else if let errorMessage = weatherViewModel.errorMessage {
                    //show errors
                    Text("Error: \(errorMessage)")
                        .foregroundStyle(.black)
                        .font(.title3)
                        .padding()
                        .multilineTextAlignment(.center)

                }
                Spacer()
            }
            .navigationTitle("Weather")
            .onAppear {
                weatherViewModel.loadSavedCity()
            }
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel(networkService: WeatherAPIService()))
}
