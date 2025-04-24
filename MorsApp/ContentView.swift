//
//  ContentView.swift
//  MorsApp
//
//  Created by Mor Naaman on 24/04/2025.
//

import SwiftUI

struct WeatherData {
    let temperature: Double
    let condition: String
    let location: String
}

struct City: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let temperature: Double
    let condition: String
}

struct ContentView: View {
    // Sample cities data (in a real app, this would come from an API)
    let cities = [
        City(name: "Tel Aviv", temperature: 22.5, condition: "Sunny"),
        City(name: "New York", temperature: 18.0, condition: "Cloudy"),
        City(name: "London", temperature: 15.5, condition: "Rainy"),
        City(name: "Tokyo", temperature: 20.0, condition: "Partly Cloudy"),
        City(name: "Paris", temperature: 17.5, condition: "Clear")
    ]
    
    @State private var selectedCity: City?
    
    var body: some View {
        VStack(spacing: 20) {
            // City Picker
            Picker("Select City", selection: $selectedCity) {
                ForEach(cities) { city in
                    Text(city.name).tag(Optional(city))
                }
            }
            .pickerStyle(.menu)
            .padding()
            
            // Location Header
            Text(selectedCity?.name ?? cities[0].name)
                .font(.title)
                .bold()
            
            // Weather Icon
            Image(systemName: getWeatherIcon(condition: selectedCity?.condition ?? cities[0].condition))
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            // Temperature
            Text("\(Int(selectedCity?.temperature ?? cities[0].temperature))°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.primary)
            
            // Condition
            Text(selectedCity?.condition ?? cities[0].condition)
                .font(.title2)
                .foregroundColor(.secondary)
            
            // Additional Info
            HStack(spacing: 40) {
                WeatherInfoView(icon: "humidity.fill", value: "65%", title: "Humidity")
                WeatherInfoView(icon: "wind", value: "12 km/h", title: "Wind")
            }
            .padding(.top, 20)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .onAppear {
            selectedCity = cities[0]
        }
    }
    
    // Helper function to return appropriate weather icon
    func getWeatherIcon(condition: String) -> String {
        switch condition.lowercased() {
        case "sunny", "clear":
            return "sun.max.fill"
        case "cloudy":
            return "cloud.fill"
        case "rainy":
            return "cloud.rain.fill"
        case "partly cloudy":
            return "cloud.sun.fill"
        default:
            return "sun.max.fill"
        }
    }
}

struct WeatherInfoView: View {
    let icon: String
    let value: String
    let title: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
            Text(value)
                .font(.title3)
                .bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    ContentView()
}
