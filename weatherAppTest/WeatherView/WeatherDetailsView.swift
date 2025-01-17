//
//  WeatherDetailsView.swift
//  weatherAppTest
//
//  Created by andres castro jaquez on 1/16/25.
//

import SwiftUI

struct WeatherDetailsView: View {
    // MARK: - Properties
    
    var weather: WeatherResponse
    
    // MARK: - Body

    var body: some View {
        VStack {
            // get Weather Icon
            AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100, maxHeight: 100)
                    
                case .failure:
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                @unknown default:
                    EmptyView()
                }
            }
            // City and Country
            weatherAndCity(weather: weather.current.tempF, city: weather.location.name)

            // Weather extra information
            HStack(spacing: 10) {
                WeatherDetailCardView(title: "Humidity", value: "\(weather.current.humidity)%")
                WeatherDetailCardView(title: "UV", value: "\(weather.current.uv)%")
                WeatherDetailCardView(title: "Feels Like", value: "\(weather.current.feelslikeF)°")
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 0.5)
        }
        .padding()
    }
}



#Preview {
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
    WeatherDetailsView(weather: sampleWeatherResponse)
}
