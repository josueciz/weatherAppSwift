//
//  ForecastViewController.swift
//  weatherAppSwift
//
//  Created by Josue on 2018/05/02.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var weather: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.borderColor = UIColor(red: 0.890, green: 0.118, blue: 0.576, alpha: 1).cgColor
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.weather = appDelegate.getWeather()
        if self.weather == nil
        {
            appDelegate.dispatchGroup.wait()
            self.weather = appDelegate.getWeather()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather!.daily.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: detailedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath as IndexPath) as! detailedTableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC+02")

        let data: WeatherModel.Data = weather!.daily.data[indexPath.row]
        cell.icon.image = data.icon.icon
        cell.dateTime.text = dateFormatter.string(from: data.time)
        cell.summary.text = data.summary
        cell.firstRowOne.text = "PI: "+String(data.precipIntensity)+"mm"
        cell.firstRowTwo.text = "MIN: "+String(data.temperatureMin)+" º"
        cell.firstRowThree.text = "DP: "+String(data.dewPoint)+" º"
        cell.firstRowFour.text = "HM: "+String(Int(data.humidity*100))+"%"
        cell.secondRowOne.text = "PP: "+String(Int(data.precipProbability*100))+"%"
        cell.secondRowTwo.text = "MAX: "+String(data.temperatureHigh)+" º"
        cell.secondRowThree.text = "PSI: "+String(data.pressure)+"hPa"
        cell.secondRowFour.text = "WS: "+String(data.windSpeed)+"kph"
        
        return cell
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
