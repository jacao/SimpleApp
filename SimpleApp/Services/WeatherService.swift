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

/**
 Service to get the latest weather forecase
 */
class WeatherService: WeatherServiceProtocol {
    
    func getTodaysWeatherForecast() -> Observable<WeatherForecast> {
        
        // Initialise a subject, this can be subscribed to, and we can publish events on it
        let subject = PublishSubject<WeatherForecast>()
        
        // Use alamofire to request the weather in Nottingham
        AF.request("http://ws1.metcheck.com/ENGINE/v9_0/json.asp?lat=53&lon=-1.1&lid=59780&Fc=No").response { response in
            
            // Attempt to parse response using SwiftyJSON
            guard let data = response.data,
                let jsonResponse = try? JSON(data: data) else {
                    
                    // If we cant parse the response into json return an error
                    subject.onError(WeatherServiceError.couldNotFeatureWeather)
                    return
            }
            
            guard let weatherJsonArray = jsonResponse["metcheckData"]["forecastLocation"]["forecast"].array, let todaysWeather = WeatherForecast(weatherJsonArray[0]) else {
                
                // If we cant parse the json into a WeatherForecase object return
                subject.onError(WeatherServiceError.couldNotFeatureWeather)
                return
            }
 
            // Publish an onNext event to emit to any subscribers containing a weather forecast object
            subject.onNext(todaysWeather)
        }
        
        // Return an observable object that can be subscribed to
        return subject
    }
    
}

internal enum WeatherServiceError: Error {
    case couldNotFeatureWeather
}
