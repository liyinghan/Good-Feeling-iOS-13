//
//  ThirdViewController.swift
//  Good Feeling iOS 13
//
//  Created by han.li on 2020/3/5.
//  Copyright © 2020 jordanlake. All rights reserved.
//

/*
 Key features
 one is weather manager: get local weahter/ input ouput / how temp, city name, weather icon
 another is recommender: click the button and get a personalized fitness workout plan(V1),
 version 2 will tune recomemnation based on weather
 
 thought process behind this secene
 - take user input, search bar
 - API  and networking -  get weather info, store it, and use it
 - change weather icon
 - change weather readings
 - get location, change city name
 - use weather data to do tips recommendation
 
 */


import UIKit
import CoreLocation


class ThirdViewController: UIViewController {
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var suggestionLabel: UILabel!
    
    //initiliza the struct
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegate
        locationManager.delegate = self
        
        // trigger location request
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        
        //set UITextField Delegate
        searchTextField.delegate = self
    } // end of viewdid load
    
    @IBAction func locationPressed(_ sender: UIButton) {
        //        locationManager.stopUpdatingLocation()
        locationManager.requestLocation()
    }
    
}// end of UI controller



//MARK: -UITextfield Delegate
extension ThirdViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please type a city name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    
} // end extension of thirdview controller


//MARK: -Weather manager Delegate
extension ThirdViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManger: WeatherManager, weather: WeatherModel) {
        print(weather.cityName)
        print(weather.tempperatureString)
        
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempperatureString
            self.cityNameLabel.text = weather.cityName
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
            self.suggestionLabel.text = weather.indexName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
} // end extension of third view controller


//MARK: -LocationManager Delegate
extension ThirdViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat)
            print(lon)
            weatherManager.fetchWeather(latitue: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
