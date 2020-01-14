//
//  WeatherManager.swift
//  Clima
//
//  Created by 이경훈 on 2020/01/14.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation


struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=97f3a27aa10ba75ab21987cfdad4ca4b&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
}
