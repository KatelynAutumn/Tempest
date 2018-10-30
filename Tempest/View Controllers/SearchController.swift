//
//  SearchController.swift
//  Tempest
//
//  Created by Katelyn Pace on 10/26/18.
//  Copyright © 2018 Katelyn Pace. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UISearchBarDelegate{
    
    
    @IBOutlet weak var locationSearch: UISearchBar!
    
    //Instance of the API Manager class so we can make API calls on this screen
    let apiManager = APIManager()
    
    var geocodingData: GeocodingData?
    var weatherData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationSearch.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func showErrorAlert() {
        let errorAlert = UIAlertController(title: "Error", message: "Please enter a valid 'City, State'.", preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        errorAlert.addAction(dismissAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    //If something goes wrong with one of the API calls, call this to make sure we aren't holding on to any geocoding or weather data
    func handleError() {
        geocodingData = nil
        weatherData = nil
        showErrorAlert()
    }
    
    func retrieveGeocodingData(searchAddress: String) {
        apiManager.geocode(address: searchAddress) { (geocodingData, error) in
            //If we recieve an error, print out the error's localized description, call the handleError function, and return
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handleError()
                return
            }
            
            if let recievedData = geocodingData {
                self.geocodingData = recievedData
                //Use that data to make a Dark Sky Call
                self.RetrieveWeatherData(latitude: recievedData.latitude, Longitude: recievedData.longitude)
            } else {
                self.handleError()
                return
            }
        }
    }
    
    
    func RetrieveWeatherData(latitude: Double, Longitude: Double) {
        apiManager.getWeather(latitude: latitude, longitude: Longitude) { (weatherData, error) in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handleError()
                return
            }
            
            if let recievedData = weatherData {
                self.weatherData = recievedData
                self.performSegue(withIdentifier: "unwindToWeatherDisplay", sender: self)
            } else {
                self.handleError()
                return
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Trying to replace any spaces in the search bar text with + signs. If you can't stop running the function
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {
            return
        }
        
        retrieveGeocodingData(searchAddress: searchAddress)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as?
            WeatherDisplayViewController, let retrievedGeocodingData = geocodingData, let retrievedWeatherData = weatherData {
            destinationVC.displayGeocodingData = retrievedGeocodingData
            destinationVC.displayWeatherData = retrievedWeatherData
        }
    }
}
