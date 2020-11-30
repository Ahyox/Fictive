//
//  LanguageManager.swift
//  Fictive
//
//  Created by Prof Ahyox on 27/11/2020.
//

import Foundation

class LanguageManager : NSObject {
    
    class func getImportantNote() -> String {
        return NSLocalizedString("importantNote", comment: "Always Important")
    }
    
    class func getErrorTitle() -> String {
        return NSLocalizedString("error", comment: "Error Title")
    }
    
    class func getErrorMessage() -> String {
        return NSLocalizedString("errorMessage", comment: "Error Message")
    }
    
    class func getPullToRefreshMessage() -> String {
        return NSLocalizedString("pullToRefresh", comment: "Pull to refresh hint")
    }
    
    class func getSearchHint() -> String {
        return NSLocalizedString("searchHint", comment: "Search hint")
    }
    
    class func getYes() -> String {
        return NSLocalizedString("yesLabel", comment: "Yes Label")
    }
    
    class func getNo() -> String {
        return NSLocalizedString("noLabel", comment: "No Label")
    }
    
    class func getInfoMessage() -> String {
        return NSLocalizedString("info", comment: "Information")
    }
    
    class func getcountyAlertMessage() -> String {
        return NSLocalizedString("countyAlertMessage", comment: "County alert warning selection")
    }
    
    class func getstatusHint() -> String {
        return NSLocalizedString("statusHint", comment: "Status Hint")
    }
    
    class func getNotificationGranted() -> String {
        return NSLocalizedString("notificationGranted", comment: "Notification Granted")
    }
    
    class func getNotificationRefused() -> String {
        return NSLocalizedString("notificationRefused", comment: "Notification Refused")
    }
    
    class func getGreenLightRules() -> [String] {
        var rules = [String]()
        
        rules.append(NSLocalizedString("greenLightText1", comment: ""))
        rules.append(NSLocalizedString("greenLightText2", comment: ""))
        rules.append(NSLocalizedString("greenLightText3", comment: ""))
        return rules
    }
    
    class func getYellowLightRules() -> [String] {
        var rules = [String]()
        
        rules.append(NSLocalizedString("yellowLightText1", comment: ""))
        rules.append(NSLocalizedString("yellowLightText2", comment: ""))
        rules.append(NSLocalizedString("yellowLightText3", comment: ""))
        return rules
    }
    
    class func getRedLightRules() -> [String] {
        var rules = [String]()
        
        rules.append(NSLocalizedString("redLightText1", comment: ""))
        rules.append(NSLocalizedString("redLightText2", comment: ""))
        rules.append(NSLocalizedString("redLightText3", comment: ""))
        return rules
    }
    
    class func getDarkRedLightRules() -> [String] {
        var rules = [String]()
        
        rules.append(NSLocalizedString("redDarkLightText1", comment: ""))
        rules.append(NSLocalizedString("redDarkLightText2", comment: ""))
        return rules
    }
    
    class func getDefaultLocationTitle() -> String {
        return NSLocalizedString("defaultNotificationTitle", comment: "Location default title")
    }
}
