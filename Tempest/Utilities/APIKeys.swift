//
//  APIKeys.swift
//  Tempest
//
//  Created by Katelyn Pace on 10/25/18.
//  Copyright © 2018 Katelyn Pace. All rights reserved.
//

import Foundation


//Struct to contain our API keys from DarkSky the Google Geocoding API
struct APIKeys {
    let googleKey = "AIzaSyCPTI9AQ-ApTK4KdHZv-H69URe2_-nFPzQ"
    //Example Geocoding rewquest:
   // https://maps.googleapis.com/maps/api/geocode/json?address= + Address + &key= + API Key
    
    let darkSkyKey = "984e4c1d5756dcf204408769d2af7102"
    //Example DarkSky request =
    //https://api.darksky.net/forecast/+ API Key + / + Latitude + , +Longitude
    
    
    
}
