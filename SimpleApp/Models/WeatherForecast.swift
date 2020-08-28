//
//  WeatherForecast.swift
//  SimpleApp
//
//  Created by Jacob Hughes on 28/08/2020.
//  Copyright © 2020 MyUNiDAYS. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherForecast {
    
    let temperature: Int
    let windspeed: Int
    let icon: String
    let iconName: String
    let weekday: String
    
    init?(_ json: JSON) {
        
        guard let temperature = json["temperature"].string,
            let windspeed = json["windspeed"].string,
            let icon = json["icon"].string,
            let iconName = json["iconName"].string,
            let weekday = json["weekday"].string else {
                return nil
        }
        
        self.temperature = Int(temperature)!
        self.windspeed = Int(windspeed)!
        self.icon = icon
        self.iconName = iconName
        self.weekday = weekday
    }
}
