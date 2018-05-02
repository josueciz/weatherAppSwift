//
//  TodayViewController.swift
//  weatherAppSwift
//
//  Created by Josue on 2018/04/25.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit

protocol TodayViewControllerDelegate{
    func getWeather() -> WeatherModel
}

class TodayViewController: UIViewController {

    var delegate: TodayViewControllerDelegate?
    var weather: WeatherModel?
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = "Cape Town"
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.weather = appDelegate.getWeather()
        if self.weather == nil
        {
            appDelegate.dispatchGroup.wait()
            self.weather = appDelegate.getWeather()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC+02")
        
        if (self.weather != nil)
        {
            weatherImage.image = weather!.currently.data.icon.icon
            date.text = dateFormatter.string(from: weather!.currently.data.time)
            tempLabel.text = String(weather!.currently.data.temperature) + " º"
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setWeather(wdp: WeatherModel)
    {
        weather = wdp
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
