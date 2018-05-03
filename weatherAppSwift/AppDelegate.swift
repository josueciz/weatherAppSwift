//
//  AppDelegate.swift
//  weatherAppSwift
//
//  Created by Josue on 2018/04/25.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    func topMostViewController() -> UIViewController
    {
        if let navigation = self.presentedViewController as? UINavigationController
        {
            if let visibleController = navigation.visibleViewController
            {
                return visibleController.topMostViewController()
            }
        }
        
        if let tab = self.presentedViewController as? UITabBarController
        {
            if let selectedTab = tab.selectedViewController
            {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        
        if self.presentedViewController == nil
        {
            return self
        }
        
        return self.presentedViewController!.topMostViewController()
    }
}

extension UIApplication {
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var weather: WeatherModel? = nil
    var previousWeather: WeatherModel? = nil
    let dispatchGroup = DispatchGroup()
    var window: UIWindow?
    var dbAccessCounter: Int = 0
    var apiCounter: Int = 0
    var scheduledTask: Any?
    let timeOpened: Date = Date(timeIntervalSinceNow: 0)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        scheduledTask = Timer.scheduledTimer(timeInterval: 1200.0, target: self, selector: #selector(self.checkPersistentStorageForData), userInfo: nil, repeats: true)
        (scheduledTask as! Timer).fire()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.saveContext()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if (weather == nil)
        {
            self.checkPersistentStorageForData()
        }
        else
        {
            let timestampPlusTimeout = weather?.currently.data.time.addingTimeInterval(900)
            if timestampPlusTimeout! < Date(timeIntervalSinceNow: 0)
            {
                self.checkPersistentStorageForData()
            }
        }
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        self.saveContext()
    }
    
    @objc func checkPersistentStorageForData()
    {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherData")
        request.returnsObjectsAsFaults = false
        self.dispatchGroup.enter()
        do {
            self.dbAccessCounter += 1
            let result = try context.fetch(request)
            if (result as! [NSManagedObject]).count > 0
            {
                for data in result as! [NSManagedObject] {
                    guard let timestamp = data.value(forKey: "timestamp") as? Date else {
                        self.getCurrentWeather()
                        return
                    }
                    
                    guard let jsonData = data.value(forKey: "dataJSON") as? Data else {
                        self.getCurrentWeather()
                        return
                    }
                    let timestampPlusTimeout = timestamp.addingTimeInterval(900)
                    let timeNow = Date(timeIntervalSinceNow: 0)
                    if timestampPlusTimeout < timeNow
                    {
                        let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
                        self.previousWeather = WeatherModel.init(JSON: json)
                        self.getCurrentWeather()
                    }
                    else
                    {
                        do
                        {
                            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
                            self.weather = WeatherModel.init(JSON: json)
                            self.dispatchGroup.leave()
                        }
                        catch
                        {
                            self.getCurrentWeather()
                        }
                    }
                }
            }
            else
            {
                self.getCurrentWeather()
            }
            
        } catch {
            if dbAccessCounter > 5
            {
                self.dispatchGroup.leave()
                self.weather = WeatherModel(JSON: [:])
                if self.previousWeather != nil
                {
                    self.weather = self.previousWeather!
                }
                self.showInternetError()
                print("Cannot get data")
                dbAccessCounter = 0
            }
            print("Failed")
        }
    }
    func getCurrentWeather()
    {
        self.apiCounter += 1
        let stringurl = "https://ec-weather-proxy.appspot.com/forecast/29e4a4ce0ec0068b03fe203fa81d457f/- 33.9249,18.4241?units=ca&delay=5&chaos=0.2".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = URL(string: stringurl)
        if let url = urlString
        {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error ?? "\nFailed to download data and get accurate error index\n")
                    if (self.apiCounter > 5)
                    {
                        self.apiCounter = 0
                        self.dispatchGroup.leave()
                        self.weather = WeatherModel(JSON: [:])
                        if self.previousWeather != nil
                        {
                            self.weather = self.previousWeather!
                        }
                        self.showInternetError()
                        print("Cannot access api")
                        return
                    }
                    else
                    {
                        self.getCurrentWeather()
                        return
                    }
                } else {
                    if let usableData = data {
                        do {
                            self.saveWeatherModel(JSONDATA: usableData)
                            let json = try JSONSerialization.jsonObject(with: usableData, options: []) as! [String: AnyObject]
                            self.weather = WeatherModel.init(JSON: json)
                            self.showAlert(previous: self.previousWeather, current: self.weather, forceDisplay: false)
                            self.dispatchGroup.leave()
                        } catch let error as NSError {
                            print("\nFailed to load: \(error.localizedDescription)\n")
                            if (self.apiCounter > 5)
                            {
                                self.apiCounter = 0
                                self.dispatchGroup.leave()
                                self.weather = WeatherModel(JSON: [:])
                                if self.previousWeather != nil
                                {
                                    self.weather = self.previousWeather!
                                }
                                self.showInternetError()
                                print("Cannot decode/serialize json data")
                                return
                            }
                            else
                            {
                                self.getCurrentWeather()
                                return
                            }
                        }
                    }
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
    
    func getTime() -> Date
    {
        return timeOpened
    }
    
    func showInternetError()
    {
        var str:String!
        
        if self.previousWeather != nil
        {
            str = "Cannot access API, please check internet connection then close and restart app.\n\nSwitching to last known data."
        }
        else
        {
            str = "Cannot access API, please check internet connection then close and restart app."
        }
        let alert = UIAlertController(title: "Connection error!", message: str, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        UIApplication.shared.topMostViewController()?.present(alert, animated: true)
    }
    
    func showAlert(previous: WeatherModel?, current: WeatherModel?,forceDisplay: Bool)
    {
        if forceDisplay
        {
            let alert = UIAlertController(title: "Temperature warning!", message: "Temperature warning: \(current!.currently.data.temperature)", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            
            UIApplication.shared.topMostViewController()?.present(alert, animated: true)
            return
        }
        if previous == nil || current == nil
        {
            return
        }
        else
        {
            if (15.0 > previous!.currently.data.temperature) && (previous!.currently.data.temperature < 25.0)
            {
                if (current!.currently.data.temperature > 25.0)
                {
                    let alert = UIAlertController(title: "Temperature warning!", message: "Temperature warning: \(current!.currently.data.temperature)", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    
                    UIApplication.shared.topMostViewController()?.present(alert, animated: true)
                }
            }
        }
    }
    // MARK: - Core Data stack
    func deleteAllData(context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherData")
        fetchRequest.includesPropertyValues = false // Only fetch the managedObjectID (not the full object structure)
        do
        {
            if let fetchResults = try context.fetch(fetchRequest) as? [NSManagedObject]
            {
                
                for result in fetchResults
                {
                    context.delete(result)
                }
            }
            self.saveContext()
        }
        catch
        {
            print("\ndeleteData - Error")
            return
        }
        print("\ndeleteData - Success")
    }
    
    func saveWeatherModel(JSONDATA: Data)
    {
        let context = self.persistentContainer.viewContext
        
        self.deleteAllData(context: context)
        
        let entity = NSEntityDescription.entity(forEntityName: "WeatherData", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(JSONDATA, forKey: "dataJSON")
        newUser.setValue(Date.init(timeIntervalSinceNow: 0), forKey: "timestamp")
        self.saveContext()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "weatherAppSwift")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

