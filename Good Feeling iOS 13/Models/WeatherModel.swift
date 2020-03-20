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
            return "天气寒冷，户外运动请注意保暖。"
        case 0 :
            return "休息一天。今天不适合户外运动。"
        case 1...10:
            return "留意身体给你的信号。如果感觉良好，那尽情训练吧。如果感到疲劳或者肌肉酸痛，那你今天需要休息调整一下。"
        case 11...25:
            return "非常适合运动的一天。训练30~45分钟后，适当补充水分。 "
        case 26...60:
            return "非常适合运动的一天。今天户外温度稍高，多喝水，训练时间不要超过2个小时。可以考虑将部分训练安排到早上或晚上。"
        case 61...200:
            return "可以考虑进行室内训练。如果进行户外训练，务必多喝水，训练时间不要超过2个小时。可以考虑将部分训练安排到早上或晚上。"
        default:
            return "开启运动的一天吧！"
        }
    } // end of indexName
    
    
}
