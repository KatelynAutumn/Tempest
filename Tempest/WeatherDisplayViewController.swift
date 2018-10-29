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

class ViewController: UIViewController {
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var weatherImage: UILabel!
    
    @IBOutlet weak var temperature: UILabel!
    
    @IBOutlet weak var high: UILabel!
    
    @IBOutlet weak var low: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let apiKeys = APIKeys()
        let darkSkyUrl = "https://api.darksky.net/forecast/"
        let darkSkyKey = apiKeys.darkSkyKey
        let latitude = "37.004842"
        let longitude = "-85.925876"
        
        let url = darkSkyUrl + darkSkyKey + "/" + latitude + "," + longitude
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let temp = json["currently"]["temperature"].double {
                    self.temperature.text = "\(temp)"
                }
                
                if let highTemp = json["daily"]["data"][0]["temperatureHigh"].double {
                    self.high.text = "\(highTemp)"
                }
                
                if let lowTemp = json["daily"]["data"][0]["temperatureLow"].double {
                    self.low.text = "\(lowTemp)"
                }
                
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let googleBaseURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
        
        let googleRequestURL = googleBaseURL + "Glasgow,+Kentucky" + "&key=" + apiKeys.googleKey
        
        let googleRequest = Alamofire.request(googleRequestURL)
        
        googleRequest.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
     
    }
}

