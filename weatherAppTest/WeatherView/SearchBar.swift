//
//  SearchBar.swift
//  weatherAppTest
//
//  Created by andres castro jaquez on 1/16/25.
//

import SwiftUI

struct SearchBar: View {
    // MARK: - Properties
    
    @Binding var city: String
    var onSearch: () -> Void
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .trailing) {
            // TextField for city input
            TextField("Enter city", text: $city, onCommit: onSearch)
                .padding() // Add internal padding for spacing inside the TextField
                .background(Color.gray.opacity(0.1)) // Gray background with some opacity
                .cornerRadius(10) // Rounded corners for the TextField
                .autocorrectionDisabled() // Disable auto-correction
                .keyboardType(.default) // Specify the keyboard type
                .padding(.horizontal) // Horizontal padding for the TextField
            
            // Search Button with icon
            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundStyle(.gray)
                    .padding(.trailing, 30)
            }
        }
    }
}

#Preview {
    SearchBar(city: .constant("New York")) {
        // Simulate the search action (no network call in the preview)
        print("Search triggered for city: New York")
    }
}
