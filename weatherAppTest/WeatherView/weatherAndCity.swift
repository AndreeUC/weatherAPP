//
//  weatherAndCity.swift
//  weatherAppTest
//
//  Created by andres castro jaquez on 1/16/25.
//

import SwiftUI

struct weatherAndCity: View {
    // MARK: - Properties
    
    var weather: Double
    var city : String
    
    // MARK: - Body
    var body: some View {
       // Create a reusable city and weather items
        VStack(alignment: .leading){
            Text(city)
                .font(.title)
                .fontWeight(.bold)
            
            
            Text("\(weather, specifier: "%.0f")")
                .font(.system(size: 50))
                .fontWeight(.bold) +
            Text("°")
                .font(.system(size: 20)) // Adjust the size as you need
                .baselineOffset(20)
                
        }
    }
}

#Preview {
    weatherAndCity(weather: 40, city: "Miami")
}
        
