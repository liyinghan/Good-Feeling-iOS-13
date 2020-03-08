//
//  WeatherModel.swift
//  Good Feeling iOS 13
//
//  Created by han.li on 2020/3/7.
//  Copyright © 2020 jordanlake. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let airHumidity: Double
    let airPressure: Double
    
    var tempperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    /*
     // figure out a sports index
     rain & snow day, not suitable for outdoor sports, index = 0;
     clear & cloud day, suitable for outdoor
     high humitidy ; not suitable for outdoor          humitidy 0~1
     high pressure; not suitable for outdoor          airpressure low pressure means high altitude.
     */
    
    var indexInt: Int {
        let index = indexCode * (temperature  + (1 / (airPressure / 1000)) - (1 - (airHumidity / 70)))
        return Int(index)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "cloud.fog"
        case 801...804:
            return "cloud"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
    
    var indexCode: Double {
        switch conditionId {
        case 200...232:
            return 0 // rain, not suitable for sport
        case 300...321:
            return 0.5 // rain, not suitable for sport
        case 500...531:
            return 0 // rain, not suitable for sport
        case 600...622:
            return 1 // snow, not suitable for sport
        case 701...781:
            return 1
        case 801...804:
            return 1
        case 800:
            return 2 // clear
        default:
            return 1 // default cloud, okay for sports
        }
    } // end of indexCode
    
    var indexName: String {
        switch indexInt {
        
        case -50 ... -1:
            return "cold weather. Dress warm if practice outside activity"
        case 0 :
            return "Well..let's take a day off. You should stop outside activity in practice"
        case 1...10:
            return "Listen to your body.If you feel good, go for it. If you don’t feel up to your regular workout or you feel sore and worn out, then you may need a lighter day."
        case 11...25:
            return "This is a good day for training. Optional water breaks approximately every 30 - 45 minutes for approximately 10 minutes duration."
        case 26...60:
            return "Go for it and drink more water. Practice length should be 2 hours or less. Consider moving practice to morning or later in the day. Limited conditioning."
        case 61...200:
            return "Try some indoor activities today.  Practice should not exceed 2-1/2 hours. Consider moving practice to morning or later in the day"
        default:
            return "You are ready for action today!"
        }
    } // end of indexName
    
    
}
