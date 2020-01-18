//
//  WeatherManager.swift
//  Clima
//
//  Created by 이경훈 on 2020/01/14.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=97f3a27aa10ba75ab21987cfdad4ca4b&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //        1. URL 만들기
        //        2. URLSession 만들기
        //        3. URLSession에 task 할당하기
        //        4. task 실행하기
        
        // Optional URL 생성
        if let url = URL(string: urlString) {
            // session 생성
            let session = URLSession(configuration: .default)
            
            // task 할당
            // sesson이 생성되고 task가 끝나면 completionHandler를 callback
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let safeWeather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: safeWeather)
                    }
                }
            }
            
            // task 실행
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            return WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
