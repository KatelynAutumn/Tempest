//
//  GeocodingData.swift
//  Tempest
//
//  Created by Katelyn Pace on 10/29/18.
//  Copyright © 2018 Katelyn Pace. All rights reserved.
//

import Foundation
import SwiftyJSON

class GeocodingData {
    //MARK:- Types
    
    //These are the keys that we will need to get the correct info from the Google Geocoding API
    enum GeocodingDataKeys: String {
        case results = "results"
        case formattedAddress = "formatted_address"
        case geometry = "geometry"
        case location = "location"
        case latitude = "late"
        case longitude = "lng"
    }
    
    //MARK:- Properties
    
    var formattedAddress: String
    var latitude: Double
    var longitude: Double
    
    //Mark:- Methods
    
    init(formattedAddress: String, latitude: Double, longitude: Double) {
    self.formattedAddress = formattedAddress
    self.latitude = latitude
    self.longitude = longitude
    }
    
    //Failable convenience initializer for breaking down data from JSON and creating geocodingdata
    
    convenience init?(json: JSON) {
        guard let results = json[GeocodingDataKeys.results.rawValue].array
            else {
            return nil
        }
        
        guard let formattedAddress = results[0][GeocodingDataKeys.formattedAddress.rawValue].string else {
            return nil
        }
        
        guard let latitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.latitude.rawValue].double else {
            return nil
        }
        
        guard let longitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.longitude.rawValue].double else {
            return nil
        }
                   
        self.init(formattedAddress: formattedAddress, latitude: latitude, longitude: longitude)
    }
}
