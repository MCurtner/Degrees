//
//  ViewController.swift
//  toDegrees
//
//  Created by Matthew Curtner on 12/31/14.
//  Copyright (c) 2014 Matthew Curtner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //@IBOutlet weak var fahrenheitImageView: UIImageView!
    //@IBOutlet weak var celsiusImageView: UIImageView!
    
    //@IBOutlet weak var fahrenheitLabel: UILabel!
    //@IBOutlet weak var celsiusLabel: UILabel!
    
    
    var celsiusLabel: UILabel! = UILabel()
    var fahrenheitLabel: UILabel! = UILabel()
    
    var location : CGPoint = CGPointZero
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let celsiusImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width/2, height: self.view.frame.size.height))
        let fahrenheitImageView = UIImageView(frame: CGRect(x: self.view.frame.size.width/2, y: 0.0, width: self.view.frame.size.width/2, height: self.view.frame.size.height))
        
        celsiusLabel =  UILabel(frame: CGRectMake(5.0, celsiusImageView.frame.height/2, celsiusImageView.frame.width - 10, 50))
        fahrenheitLabel = UILabel(frame: CGRectMake(fahrenheitImageView.frame.size.width + 10, fahrenheitImageView.frame.height/2, fahrenheitImageView.frame.size.width - 10, 50))

        celsiusImageView.backgroundColor = UIColor.blueColor()
        fahrenheitImageView.backgroundColor = UIColor.redColor()
        
        fahrenheitLabel.text = "32"
        celsiusLabel.text = "0"
        
        celsiusLabel.textAlignment = NSTextAlignment.Center
        fahrenheitLabel.textAlignment = NSTextAlignment.Center
        
        celsiusLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 50)
        fahrenheitLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 50)
        
        celsiusLabel.textColor = UIColor.whiteColor()
        fahrenheitLabel.textColor = UIColor.whiteColor()
        
        view.addSubview(celsiusImageView)
        view.addSubview(fahrenheitImageView)
        view.addSubview(celsiusLabel)
        view.addSubview(fahrenheitLabel)
        
        
        //Enable user interaction for Image Views
        fahrenheitImageView.userInteractionEnabled = true
        celsiusImageView.userInteractionEnabled = true
        
        
        
        //Fahrenheit gesture recognizers
        let upSelector: Selector = "swipeUpFahrenheit:"
        let upSwipe = UISwipeGestureRecognizer(target: self, action: upSelector)
        upSwipe.direction = UISwipeGestureRecognizerDirection.Up
        fahrenheitImageView.addGestureRecognizer(upSwipe)
        
        let downSelector: Selector = "swipeDownFahrenheit:"
        let downSwipe = UISwipeGestureRecognizer(target: self, action: downSelector)
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        fahrenheitImageView.addGestureRecognizer(downSwipe)
        
        
        //Celsius gesture recognizers
        let upSelectorCelsius: Selector = "swipeUpCelsius:"
        let upSwipeCelsius = UISwipeGestureRecognizer(target: self, action: upSelectorCelsius)
        upSwipeCelsius.direction = UISwipeGestureRecognizerDirection.Up
        celsiusImageView.addGestureRecognizer(upSwipeCelsius)

        let downSelectorCelsius: Selector = "swipeDownCelsius:"
        let downSwipeCelsius = UISwipeGestureRecognizer(target: self, action: downSelectorCelsius)
        downSwipeCelsius.direction = UISwipeGestureRecognizerDirection.Down
        celsiusImageView.addGestureRecognizer(downSwipeCelsius)
        
        //Reset gesture recognizer
        let swipeSelector: Selector = "swipeToReset:"
        let swipeRight = UISwipeGestureRecognizer(target: self, action: swipeSelector)
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(swipeRight)
        
        let panGesture:Selector = "handlePan:"
        let panUp = UIPanGestureRecognizer(target: self, action: panGesture)
        fahrenheitImageView.addGestureRecognizer(panUp)
    }
    

    
    //MARK: Temperature Conversion Methods
    func convertFahrenheitToCelsius(#fahrenheit: String) -> Float {
        var fahrValue = convertStringToFloat(tempatureLblValue: fahrenheit)
        var celsius = (fahrValue - 32.0) / 1.8000
        
        return celsius
    }
    
    func convertCelsiusToFahrenheit(#celsius: String) -> Float {
        var celsiusValue = convertStringToFloat(tempatureLblValue: celsius)
        var fahrenheit = (celsiusValue * 1.800) + 32
        
        return fahrenheit
    }
    
    //MARK: Converting Helper Methods
    func convertStringToFloat(#tempatureLblValue: String) -> Float {
        return tempatureLblValue.floatValue
    }
    
    func convertToStringValue(total: Float) -> String {
        var fmt = NSNumberFormatter()
        fmt.maximumFractionDigits = 1
        fmt.minimumIntegerDigits = 1
        return fmt.stringFromNumber(total)!
    }
    

    
    //MARK: Swipe Up/Down Fahrenheit Gesture Methods
    func swipeUpFahrenheit(sender: AnyObject) {
        println("Swipe up called")
        
        //Convert
        var currentFahrValue = convertStringToFloat(tempatureLblValue: fahrenheitLabel.text!)
        
        //Round the Value
        currentFahrValue = round(currentFahrValue)
        
        //Add one to value and
        var increasedValue = (currentFahrValue + 1)
        
        //Display Fahrenheit value
        fahrenheitLabel.text = convertToStringValue(increasedValue)
        
        //Convert Fahrenheit to Celsius
        var celsiusValue = convertFahrenheitToCelsius(fahrenheit: fahrenheitLabel.text!)
        
        //Display celsius value
        celsiusLabel.text = convertToStringValue(celsiusValue)
    }
    
    func swipeDownFahrenheit(sender: AnyObject) {
        println("Swipe down called")
       
        //Convert
        var currentFahrValue = convertStringToFloat(tempatureLblValue: fahrenheitLabel.text!)
        
        //Round the value
        currentFahrValue = round(currentFahrValue)
        
        //Add one to value and display Fahrenheit value
        fahrenheitLabel.text = convertToStringValue(currentFahrValue - 1)
        
        //Convert Fahrenheit to Celsius
        var celsiusValue = convertFahrenheitToCelsius(fahrenheit: fahrenheitLabel.text!)
        
        //Display celsius value
        celsiusLabel.text = convertToStringValue(celsiusValue)
    }
    
    //MARK: Swipe Up/Down Celsius Gesture Methods
    func swipeUpCelsius(sender: AnyObject) {
        println("Swipe up called")
        
        //Convert
        var currentCelsiusValue = convertStringToFloat(tempatureLblValue: celsiusLabel.text!)
        
        //Round the value
        currentCelsiusValue = round(currentCelsiusValue)
        
        //Add one to value and
        var increasedValue = (currentCelsiusValue + 1)
        
        //Display Fahrenheit value
        celsiusLabel.text = convertToStringValue(increasedValue)
        
        //Convert Celsius to Fahrenheit
        var fahrenheitValue = convertCelsiusToFahrenheit(celsius: celsiusLabel.text!)
        
        //Display celsius value
        fahrenheitLabel.text = convertToStringValue(fahrenheitValue)
    }
    
    func swipeDownCelsius(sender: AnyObject) {
        println("Swipe up called")
        
        //Convert
        var currentCelsiusValue = convertStringToFloat(tempatureLblValue: celsiusLabel.text!)
        
        //Round the value
        currentCelsiusValue = round(currentCelsiusValue)
        
        //Add one to value and
        var increasedValue = (currentCelsiusValue - 1)
        
        //Display Fahrenheit value
        celsiusLabel.text = convertToStringValue(increasedValue)
        
        //Convert Celsius to Fahrenheit
        var fahrenheitValue = convertCelsiusToFahrenheit(celsius: celsiusLabel.text!)
        
        //Display celsius value
        fahrenheitLabel.text = convertToStringValue(fahrenheitValue)
    }
    
    func swipeToReset(sender: AnyObject) {
        fahrenheitLabel.text = "32"
        celsiusLabel.text = "0"
    }
    
    
    func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        var currentLocation : CGPoint = CGPointMake(-location.x+translation.x, -location.y+translation.y)
        //recognizer.setTranslation(CGPointZero, inView: self.view)
        
    
        
        
        
        
        
        
        if currentLocation.y > 0.0 {
            
            //Convert
            var currentFahrValue = convertStringToFloat(tempatureLblValue: fahrenheitLabel.text!)
            
            //Round the Value
            currentFahrValue = round(currentFahrValue)
            
            //Add one to value and
            var increasedValue = (currentFahrValue - 1)
            
            //Display Fahrenheit value
            fahrenheitLabel.text = convertToStringValue(increasedValue)
            
            //Convert Fahrenheit to Celsius
            var celsiusValue = convertFahrenheitToCelsius(fahrenheit: fahrenheitLabel.text!)
            
            //Display celsius value
            celsiusLabel.text = convertToStringValue(celsiusValue)
        }
        
        if currentLocation.y <= 0.0 {
            //Convert
            var currentFahrValue = convertStringToFloat(tempatureLblValue: fahrenheitLabel.text!)
            
            //Round the Value
            currentFahrValue = round(currentFahrValue)
            
            //Add one to value and
            var increasedValue = (currentFahrValue + 1)
            
            //Display Fahrenheit value
            fahrenheitLabel.text = convertToStringValue(increasedValue)
            
            //Convert Fahrenheit to Celsius
            var celsiusValue = convertFahrenheitToCelsius(fahrenheit: fahrenheitLabel.text!)
            
            //Display celsius value
            celsiusLabel.text = convertToStringValue(celsiusValue)
        }
        
        
        println("\(currentLocation.y)")
    }

    
    
    
    
    
    /*
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        var currentLocation : CGPoint = CGPointMake(-location.x+translation.x, -location.y+translation.y)
        recognizer.setTranslation(CGPointZero, inView: self.view)

        if currentLocation.y >= 0.0 {
            
            //Convert
            var currentFahrValue = convertStringToFloat(tempatureLblValue: fahrenheitLabel.text!)
            
            //Round the Value
            currentFahrValue = round(currentFahrValue)
            
            //Add one to value and
            var increasedValue = (currentFahrValue - 1)
            
            //Display Fahrenheit value
            fahrenheitLabel.text = convertToStringValue(increasedValue)
            
            //Convert Fahrenheit to Celsius
            var celsiusValue = convertFahrenheitToCelsius(fahrenheit: fahrenheitLabel.text!)
            
            //Display celsius value
            celsiusLabel.text = convertToStringValue(celsiusValue)
        }
        
        if currentLocation.y <= 0.0 {
            //Convert
            var currentFahrValue = convertStringToFloat(tempatureLblValue: fahrenheitLabel.text!)
            
            //Round the Value
            currentFahrValue = round(currentFahrValue)
            
            //Add one to value and
            var increasedValue = (currentFahrValue + 1)
            
            //Display Fahrenheit value
            fahrenheitLabel.text = convertToStringValue(increasedValue)
            
            //Convert Fahrenheit to Celsius
            var celsiusValue = convertFahrenheitToCelsius(fahrenheit: fahrenheitLabel.text!)
            
            //Display celsius value
            celsiusLabel.text = convertToStringValue(celsiusValue)
        }
        
        
        println("\(currentLocation.y)")
    }
    
    */
    
    
    //MARK: Change UIImageView Background Color
    //TODO

}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

