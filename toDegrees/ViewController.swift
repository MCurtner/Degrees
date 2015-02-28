//
//  ViewController.swift
//  toDegrees
//
//  Created by Matthew Curtner on 12/31/14.
//  Copyright (c) 2014 Matthew Curtner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var celsiusImageView = UIImageView()
    var fahrenheitImageView = UIImageView()
    
    var celsiusLabel: UILabel! = UILabel()
    var fahrenheitLabel: UILabel! = UILabel()

    var useFont = UIFont(name: "HelveticaNeue-Thin", size: 50)
    var textColor = UIColor.whiteColor()
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create the UIImageViews
        celsiusImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width/2, height: self.view.frame.size.height))
        fahrenheitImageView = UIImageView(frame: CGRect(x: self.view.frame.size.width/2, y: 0.0, width: self.view.frame.size.width/2, height: self.view.frame.size.height))
    
        //Enable user interaction for Image Views
        fahrenheitImageView.userInteractionEnabled = true
        celsiusImageView.userInteractionEnabled = true
        
        //Create the labels
        celsiusLabel =  UILabel(frame: CGRectMake(5.0, celsiusImageView.frame.height/2, celsiusImageView.frame.width - 10, 50))
        fahrenheitLabel = UILabel(frame: CGRectMake(fahrenheitImageView.frame.size.width + 10, fahrenheitImageView.frame.height/2, fahrenheitImageView.frame.size.width - 10, 50))
        
        //Display label and offsets
        fahrenheitLabel.shadowColor = UIColor.blackColor()
        fahrenheitLabel.shadowOffset = CGSizeMake(1.0, -1.0)
        celsiusLabel.shadowColor = UIColor.blackColor()
        celsiusLabel.shadowOffset = CGSizeMake(1.0, -1.0)
        
        
        //Set the background colors
        celsiusImageView.backgroundColor = UIColor(hue: 0.610, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        fahrenheitImageView.backgroundColor = UIColor(hue: (64 + 112) / 255.0, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        
        celsiusLabel.text = "0"
        celsiusLabel.textAlignment = NSTextAlignment.Center
        celsiusLabel.font = useFont
        celsiusLabel.textColor = textColor
        
        fahrenheitLabel.text = "32"
        fahrenheitLabel.textAlignment = NSTextAlignment.Center
        fahrenheitLabel.font = useFont
        fahrenheitLabel.textColor = textColor
        
        view.addSubview(celsiusImageView)
        view.addSubview(fahrenheitImageView)
        view.addSubview(celsiusLabel)
        view.addSubview(fahrenheitLabel)
        
        //Pan Gesture
        let panFahrenGesture:Selector = "setFahrenheitTemp:"
        let panFahrenUp = UIPanGestureRecognizer(target: self, action: panFahrenGesture)
        fahrenheitImageView.addGestureRecognizer(panFahrenUp)
 
        let panCelsiusGesture:Selector = "setCelsiusTemp:"
        let panCelsiusUp = UIPanGestureRecognizer(target: self, action: panCelsiusGesture)
        celsiusImageView.addGestureRecognizer(panCelsiusUp)
        
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
    

    //Gesture Methods
    func swipeToReset(sender: AnyObject) {
        fahrenheitLabel.text = "32"
        celsiusLabel.text = "0"
    }
    
    
    func setFahrenheitTemp(recognizer:UIPanGestureRecognizer) {
        var translation: CGPoint = recognizer.translationInView(recognizer.view!)
        
        if (translation.y < -20 || translation.y > 20) {
            var sign: Int = translation.y > 0 ? -1 : 1
            
            recognizer.setTranslation(CGPointMake(0, 0), inView: self.view)
            
            //Convert
            var currentFahrValue = convertStringToFloat(tempatureLblValue: fahrenheitLabel.text!)
            
            //Round the Value
            currentFahrValue = round(currentFahrValue)
            
            //Add one to value and
            var increasedValue = (currentFahrValue + Float(sign * 1))
            
            //Update UIImageView background color
            fahrenheitImageView.backgroundColor = setFahrenTempBackgroundColor(temperature: increasedValue.f)
            celsiusImageView.backgroundColor = setCelsiusTempBackgroundColor(temperature: increasedValue.f)

            
            //Display Fahrenheit value
            fahrenheitLabel.text = convertToStringValue(increasedValue)
            
            //Convert Fahrenheit to Celsius
            var celsiusValue = convertFahrenheitToCelsius(fahrenheit: fahrenheitLabel.text!)
            
            //Display celsius value
            celsiusLabel.text = convertToStringValue(celsiusValue)
            celsiusLabel.shadowColor = UIColor.blackColor()
            celsiusLabel.shadowOffset = CGSizeMake(1.0, -1.0)
        }
    }
    
    
    func setCelsiusTemp(recognizer:UIPanGestureRecognizer) {
        var translation: CGPoint = recognizer.translationInView(recognizer.view!)
        
        if (translation.y < -20 || translation.y > 20) {
            var sign: Int = translation.y > 0 ? -1 : 1
            
            recognizer.setTranslation(CGPointMake(0, 0), inView: self.view)
            
            //Convert
            var currentCelsiusValue = convertStringToFloat(tempatureLblValue: celsiusLabel.text!)
            
            //Round the value
            currentCelsiusValue = round(currentCelsiusValue)
            
            //Add one to value and
            var increasedValue = (currentCelsiusValue + Float(sign * 1))
            
            //Update UIImageView background color
            fahrenheitImageView.backgroundColor = setFahrenTempBackgroundColor(temperature: 32.0 + (increasedValue.f * 1.800))
            celsiusImageView.backgroundColor = setCelsiusTempBackgroundColor(temperature: 32.0 + (increasedValue.f * 1.800))
            
            
            //Display Fahrenheit value
            celsiusLabel.text = convertToStringValue(increasedValue)
            
            //Convert Celsius to Fahrenheit
            var fahrenheitValue = convertCelsiusToFahrenheit(celsius: celsiusLabel.text!)
            
            //Display celsius value
            fahrenheitLabel.text = convertToStringValue(fahrenheitValue)
            fahrenheitLabel.shadowColor = UIColor.blackColor()
            fahrenheitLabel.shadowOffset = CGSizeMake(1.0, -1.0)
        }
    }
    
    
    //MARK: Change UIImageView Background Color
    func setFahrenTempBackgroundColor(#temperature: CGFloat) -> UIColor {
        var num = (-temperature + 112) / 255.0
        var backgroundColor: UIColor = UIColor(hue: num + num, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        
        return backgroundColor
    }
    
    func setCelsiusTempBackgroundColor(#temperature: CGFloat) -> UIColor {
        var num = (-temperature + 110) / 255.0
        println(num)
        var backgroundColor: UIColor = UIColor(hue: num + num, saturation: 1.0, brightness: 1.0, alpha: 1.0)

        return backgroundColor
    }
    
}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

extension Float {
    var f: CGFloat {return CGFloat(self)}
}
