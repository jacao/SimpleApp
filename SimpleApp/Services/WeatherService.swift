//
//  WeatherService.swift
//  SimpleApp
//
//  Created by Jacob Hughes on 28/08/2020.
//  Copyright © 2020 MyUNiDAYS. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

protocol WeatherServiceProtocol {
    func getTodaysWeatherForecast() -> Observable<WeatherForecast>
}

class WeatherService: WeatherServiceProtocol {
    
    func getTodaysWeatherForecast() -> Observable<WeatherForecast> {
        
        let subject = PublishSubject<WeatherForecast>()
        
        AF.request("http://ws1.metcheck.com/ENGINE/v9_0/json.asp?lat=53&lon=-1.1&lid=59780&Fc=No").response { response in
            
            guard let data = response.data,
                let jsonResponse = try? JSON(data: data) else {
                    subject.onError(WeatherServiceError.couldNotFeatureWeather)
                    return
            }
            
            guard let weatherJsonArray = jsonResponse["metcheckData"]["forecastLocation"]["forecast"].array, let todaysWeather = WeatherForecast(weatherJsonArray[0]) else {
                subject.onError(WeatherServiceError.couldNotFeatureWeather)
                return
            }
 
            subject.onNext(todaysWeather)
        }
        
        return subject
    }
    
}

internal enum WeatherServiceError: Error {
    case couldNotFeatureWeather
}
