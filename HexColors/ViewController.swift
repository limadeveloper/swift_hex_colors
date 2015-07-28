//
//  ViewController.swift
//  HexColors
//
//  Created by John Silva on 7/28/15.
//  Copyright © 2015 John Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var tf: UITextField!
    @IBOutlet var lb: UILabel!
    
    // MARK:
    // MARK: view delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tf.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK:
    // MARK: text field delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (tf.text?.characters.contains("#") != nil) {
            setHexColor()
        }else {
            simpleAlert("Alert", message: "# no found", button: "Ok")
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    // MARK:
    // MARK: methods
    func setHexColor() {
        lb.textColor = hexStringToUIColor(tf.text!)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(advance(cString.startIndex, 1))
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func simpleAlert(title:String?, message:String?, button:String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: button!, style: .Default, handler: nil)
        alertController.addAction(action)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

