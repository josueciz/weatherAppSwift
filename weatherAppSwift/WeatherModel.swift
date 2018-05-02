//
//  WeatherModel.swift
//  weatherAppSwift
//
//  Created by Josue on 2018/05/02.
//  Copyright © 2018 Private. All rights reserved.
//

import Foundation
import UIKit

class WeatherModel {
    
    struct Data {
        var apparentTemperature: Double
        var apparentTemperatureHigh: Double
        var apparentTemperatureHighTime: Date
        var apparentTemperatureLow: Double
        var apparentTemperatureLowTime: Date
        var apparentTemperatureMax: Double
        var apparentTemperatureMaxTime: Date
        var apparentTemperatureMin: Double
        var apparentTemperatureMinTime: Date
        var cloudCover: Double
        var dewPoint: Double
        var humidity: Double
        var icon: imageIcon
        var moonPhase: Double
        var ozone: Double
        var precipIntensity: Double
        var precipIntensityMax: Double
        var precipProbability: Double
        var pressure: Double
        var summary: String
        var sunriseTime: Date
        var sunsetTime: Date
        var temperature: Double
        var temperatureHigh: Double
        var temperatureHighTime: Date
        var temperatureLow: Double
        var temperatureLowTime: Date
        var temperatureMax: Double
        var temperatureMaxTime: Date
        var temperatureMin: Double
        var temperatureMinTime: Date
        var time: Date
        var uvIndex: Double
        var uvIndexTime: Date
        var windBearing: Double
        var windGust: Double
        var windSpeed: Double
        var windGustTime: Date
        
        mutating func setApparentTemperature(at: Double)
        {
            apparentTemperature = at
        }
        
        mutating func setApparentTemperatureHigh(ath: Double)
        {
            apparentTemperatureHigh = ath
        }
        
        mutating func setApparentTemperatureHighTime(atht: Date)
        {
            apparentTemperatureHighTime = atht
        }
        
        mutating func setApparentTemperatureLow(atl: Double)
        {
            apparentTemperatureLow = atl
        }
        
        mutating func setApparentTemperatureLowTime(atlt: Date)
        {
            apparentTemperatureLowTime = atlt
        }
        
        mutating func setApparentTemperatureMax(atm: Double)
        {
            apparentTemperatureMax = atm
        }
        
        mutating func setApparentTemperatureMaxTime(atmt: Date)
        {
            apparentTemperatureMaxTime = atmt
        }
        
        mutating func setApparentTemperatureMin(atm: Double)
        {
            apparentTemperatureMin = atm
        }
        
        mutating func setApparentTemperatureMinTime(atmt: Date)
        {
            apparentTemperatureMinTime = atmt
        }
        
        mutating func setCloudCover(cc: Double)
        {
            cloudCover = cc
        }
        
        mutating func setDewPoint(dp: Double)
        {
            dewPoint = dp
        }
        
        mutating func setHumidity(hum: Double)
        {
            humidity = hum
        }
        
        mutating func setMoonPhase(mp: Double)
        {
            moonPhase = mp
        }
        
        mutating func setOzone(oz: Double)
        {
            ozone = oz
        }
        
        mutating func setPrecipIntensity(pi: Double)
        {
            precipIntensity = pi
        }
        
        mutating func setPrecipProbability(pp: Double)
        {
            precipProbability = pp
        }
        
        mutating func setPressure(pres: Double)
        {
            pressure = pres
        }
        
        mutating func setSummary(sum: String)
        {
            summary = sum
        }
        
        mutating func setSunriseTime(srt: Date)
        {
            sunriseTime = srt
        }
        
        mutating func setSunsetTime(sst: Date)
        {
            sunsetTime = sst
        }
        
        mutating func setTemperature(temp: Double)
        {
            temperature = temp
        }
        
        mutating func setTemperatureHigh(temph: Double)
        {
            temperatureHigh = temph
        }
        
        mutating func setTemperatureHighTime(tempht: Date)
        {
            temperatureHighTime = tempht
        }
        
        mutating func setTemperatureLow(templ: Double)
        {
            temperatureLow = templ
        }
        
        mutating func setTemperatureLowTime(templt: Date)
        {
            temperatureLowTime = templt
        }
        
        mutating func setTemperatureMax(tempm: Double)
        {
            temperatureMax = tempm
        }
        
        mutating func setTemperatureMaxTime(tempmt: Date)
        {
            temperatureMaxTime = tempmt
        }
        
        mutating func setTemperatureMin(tempm: Double)
        {
            temperatureMin = tempm
        }
        
        mutating func setTemperatureMinTime(tempmt: Date)
        {
            temperatureMinTime = tempmt
        }
        
        mutating func setTime(tm: Date)
        {
            time = tm
        }
        
        mutating func setUvIndex(ui: Double)
        {
            uvIndex = ui
        }
        
        mutating func setUvIndexTime(uit: Date)
        {
            uvIndexTime = uit
        }
        
        mutating func setWindBearing(wb: Double)
        {
            windBearing = wb
        }
        
        mutating func setWindGust(wg: Double)
        {
            windGust = wg
        }
        
        mutating func setWindGustTime(wgt: Date)
        {
            windGustTime = wgt
        }
        
        mutating func setWindSpeed(ws: Double)
        {
            windSpeed = ws
        }
        
        mutating func macthData(JSON: Dictionary<String, Any>)
        {
            setApparentTemperature(at: JSON["apparentTemperature"] as? Double ?? -888.0)
            setCloudCover(cc: JSON["cloudCover"] as? Double ?? -888.0)
            setDewPoint(dp: JSON["dewPoint"] as? Double ?? -888.0)
            setHumidity(hum: JSON["humidity"] as? Double ?? -888.0)
            icon.setImageToData(iconType: JSON["icon"] as? String ?? "")
            setOzone(oz: JSON["ozone"] as? Double ?? -888.0)
            setPrecipIntensity(pi: JSON["precipIntensity"] as? Double ?? -888.0)
            setPrecipProbability(pp: JSON["precipProbability"] as? Double ?? -888.0)
            setPressure(pres: JSON["pressure"] as? Double ?? -888.0)
            setSummary(sum: JSON["summary"] as? String ?? "None")
            setTemperature(temp: JSON["temperature"] as? Double ?? -888.0)
            setTime(tm: NSDate(timeIntervalSince1970: JSON["time"] as? Double ?? 0) as Date)
            setUvIndex(ui: JSON["uvIndex"] as? Double ?? -888.0)
            setWindGust(wg: JSON["windGust"] as? Double ?? -888.0)
            setWindSpeed(ws: JSON["windSpeed"] as? Double ?? -888.0)
            setWindBearing(wb: JSON["windBearing"] as? Double ?? -888.0)
        }
        
        mutating func macthDataDetailed(JSON: Dictionary<String, Any>)
        {
            setApparentTemperatureHigh(ath: JSON["apparentTemperatureHigh"] as? Double ?? -888.0)
            setApparentTemperatureHighTime(atht: NSDate(timeIntervalSince1970: JSON["apparentTemperatureHighTime"] as? Double ?? 0) as Date)
            setApparentTemperatureLow(atl: JSON["apparentTemperatureLow"] as? Double ?? -888.0)
            setApparentTemperatureLowTime(atlt: NSDate(timeIntervalSince1970: JSON["apparentTemperatureLowTime"] as? Double ?? 0) as Date)
            setApparentTemperatureMax(atm: JSON["apparentTemperatureMax"] as? Double ?? -888.0)
            setApparentTemperatureMaxTime(atmt: NSDate(timeIntervalSince1970: JSON["apparentTemperatureMaxTime"] as? Double ?? 0) as Date)
            setApparentTemperatureMin(atm: JSON["apparentTemperatureMin"] as? Double ?? -888.0)
            setApparentTemperatureMinTime(atmt: NSDate(timeIntervalSince1970: JSON["apparentTemperatureMinTime"] as? Double ?? 0) as Date)
            setCloudCover(cc: JSON["cloudCover"] as? Double ?? -888.0)
            setDewPoint(dp: JSON["dewPoint"] as? Double ?? -888.0)
            setHumidity(hum: JSON["humidity"] as? Double ?? -888.0)
            icon.setImageToData(iconType: JSON["icon"] as? String ?? "")
            setMoonPhase(mp: JSON["moonPhase"] as? Double ?? -888.0)
            setOzone(oz: JSON["ozone"] as? Double ?? -888.0)
            setPrecipIntensity(pi: JSON["precipIntensity"] as? Double ?? -888.0)
            setPrecipProbability(pp: JSON["precipProbability"] as? Double ?? -888.0)
            setPressure(pres: JSON["pressure"] as? Double ?? -888.0)
            setSummary(sum: JSON["summary"] as? String ?? "None")
            setTemperatureLow(templ: JSON["temperatureLow"] as? Double ?? -888.0)
            setTemperatureLowTime(templt: NSDate(timeIntervalSince1970: JSON["temperatureLowTime"] as? Double ?? 0) as Date)
            setTemperatureMax(tempm: JSON["temperatureMax"] as? Double ?? -888.0)
            setTemperatureMaxTime(tempmt: NSDate(timeIntervalSince1970: JSON["temperatureMaxTime"] as? Double ?? 0) as Date)
            setTemperatureHigh(temph: JSON["temperatureHigh"] as? Double ?? -888.0)
            setTemperatureHighTime(tempht: NSDate(timeIntervalSince1970: JSON["temperatureHighTime"] as? Double ?? 0) as Date)
            setTemperatureMin(tempm: JSON["temperatureMin"] as? Double ?? -888.0)
            setTemperatureMinTime(tempmt: NSDate(timeIntervalSince1970: JSON["temperatureMinTime"] as? Double ?? 0) as Date)
            setTime(tm: NSDate(timeIntervalSince1970: JSON["time"] as? Double ?? 0) as Date)
            setUvIndex(ui: JSON["uvIndex"] as? Double ?? -888.0)
            setUvIndexTime(uit: NSDate(timeIntervalSince1970: JSON["uvIndexTime"] as? Double ?? 0) as Date)
            setWindGust(wg: JSON["windGust"] as? Double ?? -888.0)
            setWindGustTime(wgt: NSDate(timeIntervalSince1970: JSON["windGustTime"] as? Double ?? 0) as Date)
            setWindSpeed(ws: JSON["windSpeed"] as? Double ?? -888.0)
            setWindBearing(wb: JSON["windBearing"] as? Double ?? -888.0)
        }
    }
    
    struct imageIcon {
        var icon: UIImage
        
        mutating func setIcon(ic: UIImage)
        {
            icon = ic
        }
        
        mutating func setImageToData(iconType: String?)
        {
            if iconType != nil
            {
                switch iconType {
                case "wind":
                    setIcon(ic: UIImage(named: "windy")!)
                case "partly-cloudy-night":
                    setIcon(ic: UIImage(named: "cloudy-night")!)
                case "partly-cloudy-day":
                    setIcon(ic: UIImage(named: "cloudy-day")!)
                case "clear-day":
                    setIcon(ic: UIImage(named: "clear-day")!)
                case "cloudy":
                    setIcon(ic: UIImage(named: "cloudy")!)
                case "clear-night":
                    setIcon(ic: UIImage(named: "clear-night")!)
                case "rainy":
                    setIcon(ic: UIImage(named: "rainy")!)
                default:
                    setIcon(ic: UIImage(named: "clear-day")!)
                }
            }
            else
            {
                setIcon(ic: UIImage(named: "clear-day")!)
            }
        }
    }
    
    struct Daily {
        var icon: imageIcon
        var summary: String
        var data: [Data]
        
        mutating func setSummary(sum: String)
        {
            summary = sum
        }
        
        mutating func matchDaily(JSON: Dictionary<String, Any>)
        {
            let emptyImage = imageIcon(icon: UIImage(named: "clear-day")!)
            let curDate = Date(timeIntervalSinceNow: 0)
            let emptyData = Data(apparentTemperature: 0, apparentTemperatureHigh: 0, apparentTemperatureHighTime: curDate, apparentTemperatureLow: 0, apparentTemperatureLowTime: curDate, apparentTemperatureMax: 0, apparentTemperatureMaxTime: curDate, apparentTemperatureMin: 0, apparentTemperatureMinTime: curDate, cloudCover: 0, dewPoint: 0, humidity: 0, icon: emptyImage, moonPhase: 0, ozone: 0, precipIntensity: 0, precipIntensityMax: 0, precipProbability: 0, pressure: 0, summary: "", sunriseTime: curDate, sunsetTime: curDate, temperature: 0, temperatureHigh: 0, temperatureHighTime: curDate, temperatureLow: 0, temperatureLowTime: curDate, temperatureMax: 0, temperatureMaxTime: curDate, temperatureMin: 0, temperatureMinTime: curDate, time: curDate, uvIndex: 0, uvIndexTime: curDate, windBearing: 0, windGust: 0, windSpeed: 0, windGustTime: curDate)
            
            let dataDic: [Dictionary<String,Any>] = (JSON["data"] as? [Dictionary<String,Any>] ?? [([:])])
            if(dataDic.count > 0)
            {
                for dayData in dataDic
                {
                    var dataTemp: Data = emptyData
                    dataTemp.macthDataDetailed(JSON: dayData)
                    data.append(dataTemp)
                }
                data.remove(at: 0)
            }
            setSummary(sum: JSON["summary"] as? String ?? "None")
            icon.setImageToData(iconType: JSON["icon"] as? String ?? "")
        }
    }
    
    struct Currently {
        var data: Data
        
        mutating func matchCurrently(JSON: Dictionary<String, Any>)
        {
            if(JSON.capacity > 0)
            {
                data.macthData(JSON: JSON)
            }
        }
    }
    
    struct Flags {
        var sources: [String: String]
        var units: String
        
        mutating func setSources(sc: [String: String])
        {
            sources = sc
        }
        
        mutating func setUnits(un: String)
        {
            units = un
        }
        
        mutating func matchFlags(JSON: Dictionary<String, Any>)
        {
            setUnits(un: JSON["units"] as? String ?? "None")
            //        flags.setSources(sc: <#T##[String : String]#>)
        }
    }
    
    struct Hourly {
        var data: [Data]
        var icon: imageIcon
        var summary: String
        
        mutating func setSummary(sum: String)
        {
            summary = sum
        }
        
        mutating func matchHourly(JSON: Dictionary<String, Any>)
        {
            let emptyImage = imageIcon(icon: UIImage(named: "clear-day")!)
            let curDate = Date(timeIntervalSinceNow: 0)
            let emptyData = Data(apparentTemperature: 0, apparentTemperatureHigh: 0, apparentTemperatureHighTime: curDate, apparentTemperatureLow: 0, apparentTemperatureLowTime: curDate, apparentTemperatureMax: 0, apparentTemperatureMaxTime: curDate, apparentTemperatureMin: 0, apparentTemperatureMinTime: curDate, cloudCover: 0, dewPoint: 0, humidity: 0, icon: emptyImage, moonPhase: 0, ozone: 0, precipIntensity: 0, precipIntensityMax: 0, precipProbability: 0, pressure: 0, summary: "", sunriseTime: curDate, sunsetTime: curDate, temperature: 0, temperatureHigh: 0, temperatureHighTime: curDate, temperatureLow: 0, temperatureLowTime: curDate, temperatureMax: 0, temperatureMaxTime: curDate, temperatureMin: 0, temperatureMinTime: curDate, time: curDate, uvIndex: 0, uvIndexTime: curDate, windBearing: 0, windGust: 0, windSpeed: 0, windGustTime: curDate)
            
            setSummary(sum: JSON["summary"] as? String ?? "None")
            icon.setImageToData(iconType: JSON["icon"] as? String ?? "")
            let dataDic: [Dictionary<String,Any>] = (JSON["data"] as? [Dictionary<String,Any>] ?? [([:])])
            if(dataDic.count > 0)
            {
                for dayData in dataDic
                {
                    var dataTemp: Data = emptyData
                    dataTemp.macthData(JSON: dayData)
                    data.append(dataTemp)
                }
                data.remove(at: 0)
            }
        }
    }
    
    let latitude: Double
    var timezone: String
    var offset: Double
    var longitude: Double
    var daily: Daily
    var currently: Currently
    var hourly: Hourly
    var flags: Flags
    
    init(JSON: Dictionary<String, Any>)
    {
        let emptyImage = imageIcon(icon: UIImage(named: "clear-day")!)
        let curDate = Date(timeIntervalSinceNow: 0)
        let emptyData = Data(apparentTemperature: 0, apparentTemperatureHigh: 0, apparentTemperatureHighTime: curDate, apparentTemperatureLow: 0, apparentTemperatureLowTime: curDate, apparentTemperatureMax: 0, apparentTemperatureMaxTime: curDate, apparentTemperatureMin: 0, apparentTemperatureMinTime: curDate, cloudCover: 0, dewPoint: 0, humidity: 0, icon: emptyImage, moonPhase: 0, ozone: 0, precipIntensity: 0, precipIntensityMax: 0, precipProbability: 0, pressure: 0, summary: "", sunriseTime: curDate, sunsetTime: curDate, temperature: 0, temperatureHigh: 0, temperatureHighTime: curDate, temperatureLow: 0, temperatureLowTime: curDate, temperatureMax: 0, temperatureMaxTime: curDate, temperatureMin: 0, temperatureMinTime: curDate, time: curDate, uvIndex: 0, uvIndexTime: curDate, windBearing: 0, windGust: 0, windSpeed: 0, windGustTime: curDate)
        latitude = JSON["latitude"] as? Double ?? -888.0
        timezone = JSON["timezone"] as? String ?? "None"
        offset = JSON["offset"] as? Double ?? -888.0
        longitude = JSON["longitude"] as? Double ?? -888.0
        daily = Daily(icon: emptyImage, summary: "", data: [emptyData])
        currently = Currently(data: emptyData)
        hourly = Hourly(data: [emptyData], icon: emptyImage, summary: "")
        flags = Flags(sources: ["":""], units: "")
        let dailyDic: Dictionary<String,Any> = JSON["daily"] as? Dictionary<String,Any> ?? [:]
        if(dailyDic.capacity > 0)
        {
            daily.matchDaily(JSON: dailyDic)
        }
        let currentDic: Dictionary<String,Any> = JSON["currently"] as? Dictionary<String,Any> ?? [:]
        if(currentDic.capacity > 0)
        {
            currently.matchCurrently(JSON: currentDic)
        }
        let hourlyDic: Dictionary<String,Any> = JSON["hourly"] as? Dictionary<String,Any> ?? [:]
        if(hourlyDic.capacity > 0)
        {
            hourly.matchHourly(JSON: hourlyDic)
        }
        let flagDic: Dictionary<String,Any> = JSON["flags"] as? Dictionary<String,Any> ?? [:]
        if(flagDic.capacity > 0)
        {
            flags.matchFlags(JSON: flagDic)
        }
    }
    
    
    
}


