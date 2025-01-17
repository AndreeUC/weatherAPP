//
//  WeatherDetailCardView.swift
//  weatherAppTest
//
//  Created by andres castro jaquez on 1/16/25.
//

import SwiftUI

struct WeatherDetailCardView: View {
    // MARK: - Properties
    var title: String
    var value: String
    
    // MARK: - Body
    var body: some View {
        //Create a reusable item to display humidity, uv or any req value
        VStack {
            Text(title)
                .font(.headline)
                .fontWeight(.light)
            Text(value)
                .font(.headline)
                .fontWeight(.light)
        }
        .background(.clear)
        .opacity(0.3)
        .padding()
        
    }
}


#Preview {
    WeatherDetailCardView(title: "uv", value: "3")
}
