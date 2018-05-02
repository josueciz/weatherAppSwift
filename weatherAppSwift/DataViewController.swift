//
//  DataViewController.swift
//  weatherAppSwift
//
//  Created by Josue on 2018/04/25.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    var weather: WeatherModel?
    var dataObject: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let title = dataObject
        self.dataLabel!.text = title
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        if (title.elementsEqual("Today"))
        {
            
            let todayVC:TodayViewController = mainStoryboard.instantiateViewController(withIdentifier: "mainView") as! TodayViewController
            self.displayContentController(content: todayVC)
        }
        else if(title.elementsEqual("Details for Today"))
        {
            let detailVC = mainStoryboard.instantiateViewController(withIdentifier: "detailedView")
            self.displayContentController(content: detailVC)
        }
        else if(title.elementsEqual("Forecast"))
        {
            let forecastVC = mainStoryboard.instantiateViewController(withIdentifier: "sevenDayView")
            self.displayContentController(content: forecastVC)
        }
    }
    
    func displayContentController(content: UIViewController)
    {
        self.addChildViewController(content)
        content.view.frame = self.frameForContentController()
        self.view.addSubview(content.view)
        content.didMove(toParentViewController: self)
    }
    
    func frameForContentController() -> CGRect
    {
        return containerView.frame;
    }


}

