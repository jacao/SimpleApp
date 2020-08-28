//
//  ViewController.swift
//  SimpleApp
//
//  Created by Jacob Hughes on 24/08/2020.
//  Copyright © 2020 MyUNiDAYS. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    let viewModel = WeatherViewModel()
    
    var spinner = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.autoAlignAxis(toSuperviewAxis: .horizontal)
        spinner.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.renderWeather() 
    }
    
    func renderWeather() {
        
        _ = self.viewModel.getTodaysWeatherForecast().subscribe(
            onNext: { weatherForecast in
            
                
                
            }
        )
    }
}

