//
//  CurrentWeatherForecast.swift
//  CloudCast
//
//  Created by Michael Dacanay on 10/7/23.
//

import Foundation

struct CurrentWeatherForecast {
  let windSpeed: Double
  let windDirection: Double
  let temperature: Double
  let weatherCodeRaw: Int
  var weatherCode: WeatherCode {
    return WeatherCode(rawValue: weatherCodeRaw) ?? .clearSky
  }
}
