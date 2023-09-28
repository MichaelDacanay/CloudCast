//
//  ForecastViewController.swift
//  CloudCast
//
//  Created by Michael Dacanay on 9/26/23.
//

import UIKit

class ForecastViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        // Make sure the order of your parameters matches the order of your struct. The compiler will help you out here!
        let fakeData = WeatherForecast(temperature: 25.0, date: Date(), weatherCode: .partlyCloudy)
        configure(with: fakeData)
    }
    
    private func configure(with forecast: WeatherForecast) {
        forecastImageView.image = forecast.weatherCode.image
        descriptionLabel.text = forecast.weatherCode.description
        temperatureLabel.text = "\(forecast.temperature)°F"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: forecast.date)
    }
    

    

}
