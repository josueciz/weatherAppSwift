//
//  AppDelegate.swift
//  weatherAppSwift
//
//  Created by Josue on 2018/04/25.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var weather: WeatherModel? = nil
    let dispatchGroup = DispatchGroup()
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.getCurrentWeather()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func getCurrentWeather()
    {
        let stringurl = "https://ec-weather-proxy.appspot.com/forecast/29e4a4ce0ec0068b03fe203fa81d457f/- 33.9249,18.4241?units=ca&delay=5&chaos=0.2".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = URL(string: stringurl)
        if let url = urlString
        {
            self.dispatchGroup.enter()
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error ?? "\nFailed to download data and get accurate error index\n")
                } else {
                    if let usableData = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: usableData, options: []) as! [String: AnyObject]
                            self.weather = WeatherModel.init(JSON: json)
                        } catch let error as NSError {
                            print("\nFailed to load: \(error.localizedDescription)\n")
                        }
                    }
                }
                if self.weather == nil
                {
                    self.getCurrentWeather()
                }
                else
                {
                    self.dispatchGroup.leave()
                }
            }
            task.resume()
        }
    }
    
    func getWeather() -> WeatherModel?
    {
        if self.weather != nil
        {
            return self.weather!
        }
        return nil
    }


}

