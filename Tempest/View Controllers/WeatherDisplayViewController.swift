//
//  WeatherDisplayViewController.swift
//  Tempest
//
//  Created by Katelyn Pace on 10/25/18.
//  Copyright © 2018 Katelyn Pace. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherDisplayViewController: UIViewController {
   

    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var weatherImage: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    
    
    var displayWeatherData: WeatherData! {
        didSet {
            weatherImage.text = displayWeatherData.condition.icon
            temperature.text = "\(displayWeatherData.temperature)º"
            high.text = "\(displayWeatherData.highTemperature)º"
            low.text = "\(displayWeatherData.lowTemperature)º"
            
        }
    }
    var displayGeocodingData: GeocodingData! {
        didSet {
            location.text = displayGeocodingData.formattedAddress
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupDefaultUI()  
    }
    
    func setupDefaultUI() {
        location.text = ""
        weatherImage.text = "🌍"
        temperature.text = "Enter a location!"
        high.text = "-"
        low.text = "-"
    }
    
    //Unwind action so that we can unwind to this screen after retrieving data
    @IBAction func unwindToWeatherDisplay(segue: UIStoryboardSegue) { }
}

