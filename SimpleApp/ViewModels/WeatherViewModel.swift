//
//  ViewModel.swift
//  SimpleApp
//
//  Created by Jacob Hughes on 28/08/2020.
//  Copyright © 2020 MyUNiDAYS. All rights reserved.
//

import Foundation
import RxSwift

/**
 View model for main view controller
 */
class WeatherViewModel {
    
    fileprivate let weatherService: WeatherServiceProtocol
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    /**
     Get todays weather forecast using weather service
     */
    func getTodaysWeatherForecast() -> Observable<WeatherForecast> {
        return self.weatherService.getTodaysWeatherForecast()
    }
}
