//
//  ViewController.swift
//  Whats The Weather
//
//  Created by VEERASEKHAR ADDEPALLI on 27/12/16.
//  Copyright © 2016 VEERASEKHAR ADDEPALLI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    
    @IBOutlet var cityTextField: UITextField!
    
    
    
    @IBOutlet var resultLabel: UILabel!
    
    
    
    @IBAction func getWeather(_ sender: Any) {
        
        
      let location = cityTextField.text!
        
        if  let url = URL(string: "http://www.weather-forecast.com/locations/" + location.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest"){
            
            guard location != "" else{
                resultLabel.text = "Please enter a city name!"
                return
            }
        
        let urlRequest = URLRequest(url: url)
        
        let task =  URLSession.shared.dataTask(with: urlRequest, completionHandler: {
        
        (data, response, error) -> Void in
            
            var message = ""
            
        if error != nil
        {
            print (error)
            }
        else
        {
            if let unwrappedData = data{
                let dataString = String(data: unwrappedData, encoding: String.Encoding.utf8)
                
                
               var stringSeperator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                
                if let contentArray = dataString?.components(separatedBy: stringSeperator)
                {
                    if contentArray.count > 1
                    {
                        stringSeperator = "</span"
                        let newContentArray = contentArray[1].components(separatedBy: stringSeperator)
                        
                            if newContentArray.count > 1
                            {
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                //print(message)
                            }
                        
                    }
                }
                
            }
            }
            
            
            if message == "" {
                message = "The weather there could not be found. Please try again!"
            }
            
            DispatchQueue.main.sync(execute: { 
                
                self.resultLabel.text = message
            })
        
        })
        
        task.resume()
        }
        else
        {
            resultLabel.text = "The weather there could not be found. Please try again!"
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

