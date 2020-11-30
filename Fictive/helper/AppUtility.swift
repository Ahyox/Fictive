//
//  AppUtility.swift
//  Fictive
//
//  Created by Prof Ahyox on 24/11/2020.
//

import Foundation
import UIKit

class AppUtility: NSObject { 
    //Get device screen height
    class func getScreenHeight() -> CGFloat{
        return UIScreen.main.bounds.height
    }
        
    //Get device screen weight
    class func getScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
        
    //Set a rounded corner for a view
    class func setCornerRadius( _ view:AnyObject, radius:CGFloat) {
        (view as? UIView)!.layer.cornerRadius = radius
        (view as? UIView)!.layer.masksToBounds = true
    }
        
    //Set border color for a view
    class func setBorderWithColor(_ textField:AnyObject, borderColor: UIColor, borderSize:CGFloat) {
        (textField as? UIView)!.layer.borderWidth = borderSize
        (textField as? UIView)!.layer.borderColor = borderColor.cgColor
    }
        
    //Set shadow for a view
    class func setShadow( _ view:AnyObject,opacity:Float, radius:CGFloat) {
        (view as? UIView)!.layer.shadowColor = UIColor.darkGray.cgColor
        (view as? UIView)!.layer.shadowOpacity = opacity
        //(view as? UIView)!.layer.shadowOffset = CGSize.zero
        (view as? UIView)!.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        (view as? UIView)!.layer.shadowRadius = radius
        (view as? UIView)!.layer.masksToBounds = true
        (view as? UIView)!.clipsToBounds = true
    }
        
    //Set padding for a view
    class func setPaddingView(_ textField:UITextField, width:CGFloat)
        {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: textField.frame.height))
            textField.leftView = paddingView
            textField.leftViewMode = UITextField.ViewMode.always
            textField.rightView = paddingView
            textField.rightViewMode = UITextField.ViewMode.always
    }
        
    class  func isIpad() -> Bool {
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad){
            return true
        }
        return false
    }
        
    //Check if it's iphone 4
    class  func isIphone4() -> Bool {
        if (self.getScreenHeight() == 480) {
            return true
        }
        return false
    }
        
    //Check if it's iphone 5
    class  func isIphone5() -> Bool {
        if (self.getScreenHeight() == 568) {
            return true
        }
        return false
    }
        
    //Check if it's iphone 6
    class  func isIphone6() -> Bool {
        if (self.getScreenHeight() == 667){
            return true
        }
        return false
    }
        
    //Check if its iphone 6 plus
    class func isIphone6P() -> Bool {
        if (self.getScreenHeight() >= 736) {
            return true
        }
        return false
    }
        
    //Display loading spinner
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
            
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
            
        return spinnerView
    }
        
    //Remove loading spinner
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
    class func alertMessage(title:String, message:String, view:UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
        view.present(alert, animated: true)
    }
    
    class func debugMessage(message:String) {
        print("robot: \(message)")
    }
        
}

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func elevate(color:UIColor, radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 12.0
        self.layer.shadowOpacity = 0.7
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

