//
//  WeatherViewController.swift
//  Magic Weather
//
//  Created by Cody Kerns on 12/14/20.
//

import UIKit
import Purchases

/*
 The app's main view controller that displays our pretend weather data.
 Configured in /Resources/UI/Main.storyboard
 */

class WeatherViewController: UIViewController {

    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var environmentButton: UIButton!
    @IBOutlet var magicButton: UIButton!

    var currentEnvironment: SampleWeatherData.Environment = .earth
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// - Set the default weather data on load
        setWeatherData(.testCold)
    }

    @IBAction
    func performMagic() {
        self.setWeatherData(SampleWeatherData.generateSampleData(for: self.currentEnvironment))
    }
    
    func setWeatherData(_ data: SampleWeatherData) {
        self.temperatureLabel.text = "\(data.emoji)\n\(data.temperature)°\(data.unit.rawValue.capitalized)"
        self.environmentButton.setTitle("  " + data.environment.rawValue.capitalized, for: .normal)
        self.view.backgroundColor = data.weatherColor
    }
}
