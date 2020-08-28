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
    
    enum WeatherIcon {
        case sunny
        case partiallySunny
        case rainy
        case cloudy
        case snowy
        
        init(rawValue: String) {
            switch rawValue {
            case "SU": self = .sunny
            case "PC", "FA": self = .partiallySunny
            case "SH", "RO", "LR": self = .rainy
            case "CL": self = .cloudy
            case "SN": self = .snowy
            default: self = .cloudy
            }
        }
        
        var iconAsset: String {
            switch self {
            case .sunny: return "sunny"
            case .partiallySunny: return "partially-sunny"
            case .rainy: return "rainy"
            case .cloudy: return "cloudy"
            case .snowy: return "snowy"
            }
        }
    }
    
    let temperature: Int
    let windspeed: Int
    let icon: WeatherIcon
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
        self.icon = WeatherIcon(rawValue: icon)
        self.iconName = iconName
        self.weekday = weekday
    }
}
