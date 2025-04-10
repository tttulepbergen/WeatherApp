//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Тулепберген Анель  on 10.04.2025.
//

import Foundation
import SwiftUI

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather?
    @Published var forecast: ForecastResponse?

    @Published var currentWeatherState: LoadingState = .idle
    @Published var forecastState: LoadingState = .idle

    private let weatherService: WeatherServiceProtocol
    private let latitude: Double
    private let longitude: Double

    init(
        weatherService: WeatherServiceProtocol = WeatherService(),
        latitude: Double = 40.7128,
        longitude: Double = -74.0060
    ) {
        self.weatherService = weatherService
        self.latitude = latitude
        self.longitude = longitude
    }

    func fetchWeatherData() {
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask { await self.loadCurrentWeather() }
                group.addTask { await self.loadForecast() }
            }
        }
    }

    private func loadCurrentWeather() async {
        currentWeatherState = .loading
        do {
            let result = try await weatherService.getCurrentWeather(lat: latitude, lon: longitude)
            currentWeather = result
            currentWeatherState = .success
        } catch {
            currentWeatherState = .failure(error.localizedDescription)
        }
    }

    private func loadForecast() async {
        forecastState = .loading
        do {
            let result = try await weatherService.getForecast(lat: latitude, lon: longitude)
            forecast = result
            forecastState = .success
        } catch {
            forecastState = .failure(error.localizedDescription)
        }
    }


    func refresh() {
        fetchWeatherData()
    }
}

