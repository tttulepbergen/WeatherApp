//
//  WeatherAPIManager.swift
//  WeatherApp
//
//  Created by Тулепберген Анель  on 10.04.2025.
//

import Foundation

enum WeatherAPIError: Error {
    case invalidURL
    case requestFailed
    case decodingError
}

struct WeatherAPIManager {
    static let shared = WeatherAPIManager()
    private init() {}

    private let apiKey = "8aebf8a0146bb5a8c1f2ab163e999174"
    private let baseURL = "https://api.openweathermap.org/data/2.5"

    func fetch<T: Decodable>(_ endpoint: String, parameters: [String: String]) async throws -> T {
        var components = URLComponents(string: baseURL + endpoint)
        var queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        queryItems.append(URLQueryItem(name: "appid", value: apiKey))
        queryItems.append(URLQueryItem(name: "units", value: "metric"))
        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw WeatherAPIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw WeatherAPIError.requestFailed
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw WeatherAPIError.decodingError
        }
    }
}
