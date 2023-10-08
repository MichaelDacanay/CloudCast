//
//  ForecastViewController.swift
//  CloudCast
//
//  Created by Michael Dacanay on 9/26/23.
//

import UIKit

struct Location {
  let name: String
  let latitude: Double
  let longitude: Double
}

class ForecastViewController: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        selectedForecastIndex = max(0, selectedForecastIndex - 1) // don't go lower than 0 index
        configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
        
        selectedLocationIndex = max(0, selectedLocationIndex - 1) // make sure selectedLocationIndex is always >= 0
        changeLocation(withLocationIndex: selectedLocationIndex)
        
    }
    @IBAction func didTapForwardButton(_ sender: UIButton) {
        selectedForecastIndex = min(forecasts.count - 1, selectedForecastIndex + 1) // don't go higher than the number of forecasts
        configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
        
        selectedLocationIndex = min(locations.count - 1, selectedLocationIndex + 1) // make sure selectedLocationIndex is always < locations.count
        changeLocation(withLocationIndex: selectedLocationIndex)
    }
    
    private var forecasts = [WeatherForecast]() // tracks all the possible forecasts
    private var selectedForecastIndex = 0 // tracks which forecast is being shown, defaults to 0
    
    private var locations = [Location]() // stores the different locations
    private var selectedLocationIndex = 0 // keeps track of the current selected location
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        addGradient()
        
        // Create a few locations to show the forecast for. Feel free to add your own custom location!
        let sanJose = Location(name: "San Jose", latitude: 37.335480, longitude: -121.893028)
        let manila = Location(name: "Manila", latitude: 12.8797, longitude: 121.7740)
        let italy = Location(name: "Italy", latitude: 41.8719, longitude: 12.5674)
        locations = [sanJose, manila, italy]
        
        forecasts = createMockData()
//        let fakeData = WeatherForecast(temperature: 25.0, date: Date(), weatherCode: .partlyCloudy)
//        configure(with: fakeData)
        configure(with: forecasts[selectedForecastIndex]) // configure the UI to show the first mock data
        
        changeLocation(withLocationIndex: 0) // when the view loads, make sure the first location is shown
    }
    private func changeLocation(withLocationIndex locationIndex: Int) {
        guard locationIndex < locations.count else { return }
        let location = locations[locationIndex]
        locationLabel.text = location.name
    }
    
    // Returns an array of fake WeatherForecast data models to show
    private func createMockData() -> [WeatherForecast] {
        // This is just using the Calendar API to get a few random dates
        let today = Date()
        var dateComponents = DateComponents()
        dateComponents.day = 1
        let tomorrow = Calendar.current.date(byAdding: dateComponents, to: today)!
        let dayAfterTomorrow = Calendar.current.date(byAdding: dateComponents, to: tomorrow)!
        // Create a few mock data to show
        let mockData1 = WeatherForecast(temperature: 59.5,
                                        date:today,
                                        weatherCode: .rainShowersViolent
//                                        windSpeed: 3.3,
//                                        precipitation: 33.3,
                                        )
        let mockData2 = WeatherForecast(temperature: 65.5,
                                        date: tomorrow,
                                        weatherCode: .fog
//                                        windSpeed: 3.7,
//                                        precipitation: 13.3,
                                        )
        let mockData3 = WeatherForecast(temperature: 49.5,
                                        date: dayAfterTomorrow,
                                        weatherCode: .partlyCloudy
//                                        windSpeed: 2.8,
//                                        precipitation: 23.3,
                                        )
        return [mockData1, mockData2, mockData3]
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 0.54, green: 0.88, blue: 0.99, alpha: 1.00).cgColor,
                                UIColor(red: 0.51, green: 0.81, blue: 0.97, alpha: 1.00).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
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
