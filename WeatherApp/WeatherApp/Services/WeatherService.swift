//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Тулепберген Анель  on 10.04.2025.
//


import Foundation

protocol WeatherServiceProtocol {
    func getCurrentWeather(lat: Double, lon: Double) async throws -> CurrentWeather
    func getForecast(lat: Double, lon: Double) async throws -> ForecastResponse
}

struct WeatherService: WeatherServiceProtocol {
    func getCurrentWeather(lat: Double, lon: Double) async throws -> CurrentWeather {
        try await WeatherAPIManager.shared.fetch("/weather", parameters: [
            "lat": "\(lat)",
            "lon": "\(lon)"
        ])
    }

    func getForecast(lat: Double, lon: Double) async throws -> ForecastResponse {
        try await WeatherAPIManager.shared.fetch("/forecast", parameters: [
            "lat": "\(lat)",
            "lon": "\(lon)"
        ])
    }

    
}
