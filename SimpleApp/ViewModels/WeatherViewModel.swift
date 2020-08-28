//
//  ViewModel.swift
//  SimpleApp
//
//  Created by Jacob Hughes on 28/08/2020.
//  Copyright © 2020 MyUNiDAYS. All rights reserved.
//

import Foundation
import RxSwift

class WeatherViewModel {
    
    fileprivate let weatherService: WeatherServiceProtocol
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func getTodaysWeatherForecast() -> Observable<WeatherForecast> {
        return self.weatherService.getTodaysWeatherForecast()
    }
}
