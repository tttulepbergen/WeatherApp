//
//  LoadingState.swift
//  WeatherApp
//
//  Created by Тулепберген Анель  on 11.04.2025.
//

import Foundation

enum LoadingState {
    case idle
    case loading
    case success
    case failure(String)
}
