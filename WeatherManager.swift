//
//  WeatherManager.swift
//  Clima
//
//  Created by 이경훈 on 2020/01/14.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=97f3a27aa10ba75ab21987cfdad4ca4b&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
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
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    print(dataString)
                }
            }
            
            // task 실행
            task.resume()
        }
        
    }
}
