//
//  WeatherModels.swift
//  WeatherApp
//
//  Created by Тулепберген Анель  on 10.04.2025.
//


import Foundation

struct CurrentWeather: Decodable {
    let name: String?
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
}

struct Weather: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct Wind: Decodable {
    let speed: Double
}

struct ForecastResponse: Decodable {
    let list: [ForecastItem]
}

struct ForecastItem: Decodable {
    let dt: TimeInterval
    let main: Main
    let weather: [Weather]
    let dt_txt: String?
}

