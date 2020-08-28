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
    
    fileprivate var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        let title = UILabel()
        title.text = "Todays Weather"
        title.font = UIFont.init(name: "Helvetica", size: 30)
        view.addSubview(title)
        title.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        title.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.autoAlignAxis(toSuperviewAxis: .horizontal)
        spinner.autoAlignAxis(toSuperviewAxis: .vertical)
        
        self.renderWeather() 
    }
    
    func renderWeather() {
        
        self.viewModel.getTodaysWeatherForecast().subscribe(
            onNext: { weatherForecast in
            
                self.spinner.stopAnimating()
                let weatherView = self.buildWeatherView(weatherForecast)
                self.view.addSubview(weatherView)
                weatherView.autoAlignAxis(toSuperviewAxis: .vertical)
                weatherView.autoAlignAxis(toSuperviewAxis: .horizontal)
            }
        ).disposed(by: self.disposeBag)
    }
    
    func buildWeatherView(_ weatherForecast: WeatherForecast) -> UIView {
        
        let container = UIView()
           
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        container.addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges()
           
        let weatherDescription = UILabel()
        weatherDescription.text = weatherForecast.iconName
        weatherDescription.font = UIFont.init(name: "Helvetica", size: 20)
        stackView.addArrangedSubview(weatherDescription)
           
        let icon = UIImage(named: weatherForecast.icon.iconAsset)
        let iconView = UIImageView(image: icon)
        stackView.addArrangedSubview(iconView)
           
        let tempretureView = UIView()
        stackView.addArrangedSubview(tempretureView)
          
        let tempImage = UIImage(named: "temp")
        let tempImageView = UIImageView(image: tempImage)
           
        tempretureView.addSubview(tempImageView)
        tempImageView.autoPinEdge(toSuperviewEdge: .top)
        tempImageView.autoPinEdge(toSuperviewEdge: .left)
        tempImageView.autoPinEdge(toSuperviewEdge: .bottom)
        tempImageView.autoSetDimensions(to: CGSize(width: 50, height: 50))
           
        let tempLabel = UILabel()
        tempLabel.text = "\(weatherForecast.temperature)\u{00B0}"
           
        tempretureView.addSubview(tempLabel)
        tempLabel.autoPinEdge(.left, to: .right, of: tempImageView)
        tempLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        tempLabel.autoPinEdge(toSuperviewEdge: .right)
        
        return container
    }
}

