//
//  CityCardView.swift
//  weatherAppTest
//
//  Created by andres castro jaquez on 1/16/25.
//

import SwiftUI

struct CityCardView: View {
    // MARK: - Properties
    var weather: WeatherResponse
    
    // MARK: - Body
    var body: some View {
        HStack{
            //Create the card that will display the city and weather
            weatherAndCity(weather: weather.current.tempF, city: weather.location.name)
            Spacer()
            AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)"))
                .scaledToFit()
                .frame(maxWidth: 100, maxHeight: 100)
                .cornerRadius(10)
                .padding()
        }
        .padding()
        .frame(width: 360, height: 120)
        .background(Color.gray.opacity(0.2))
    }
}

#Preview() {
    let sampleWeatherResponse = WeatherResponse(
        location: Location(
            name: "New York",
            region: "NY",
            country: "USA",
            lat: 40.7128,
            lon: -74.0060,
            tzID: "America/New_York",
            localtimeEpoch: 1675326400,
            localtime: "2025-01-15 10:00"
        ),
        current: Current(
            tempC: 10.0,
            tempF: 50.0,
            condition: Condition(text: "Clear", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png", code: 1000),
            humidity: 60,
            feelslikeC: 8.0,
            feelslikeF: 46.4,
            uv: 3.0
        )
    )
    
    // Pass the `sampleWeatherResponse` to the `WeatherDetailsView`
    CityCardView(weather: sampleWeatherResponse)

}
