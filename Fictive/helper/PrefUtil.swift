//
//  PrefUtil.swift
//  Fictive
//
//  Created by Prof Ahyox on 28/11/2020.
//

import Foundation

class PrefUtil : NSObject {
    
    class func setSelectedCounty(county:String) {
        USER_PREF.set(county, forKey: SELECTED_COUNTY)
    }
    
    class func getSelectedCounty() -> String {
        if USER_PREF.object(forKey: SELECTED_COUNTY) != nil {
            return USER_PREF.object(forKey: SELECTED_COUNTY) as! String
        } else {
            return ""
        }
    }
    
    class func setCurrentCase(currentCase:Int) {
        USER_PREF.set(currentCase, forKey: CURRENT_CASE)
    }
    
    class func getCurrentCase() -> Int {
        if USER_PREF.object(forKey: CURRENT_CASE) != nil {
            return USER_PREF.object(forKey: CURRENT_CASE) as! Int
        } else {
            return 0
        }
    }
}
