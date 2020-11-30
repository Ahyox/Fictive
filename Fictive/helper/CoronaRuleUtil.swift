//
//  CoronaRuleChecker.swift
//  Fictive
//
//  Created by Prof Ahyox on 29/11/2020.
//

import Foundation

class CoronaRuleUtil {
    var feature:Features!
    
    init(feature:Features) {
        self.feature = feature
    }
    
    func check() -> Int {
        AppUtility.debugMessage(message: "\(feature.attributes.cases7Per100k)")
        if feature.attributes.cases7Per100k < 35 {
            //GREEN Light
            return GREEN_LIGHT
        } else if feature.attributes.cases7Per100k >= 35 && feature.attributes.cases7Per100k <= 50 {
            //YELLOW Light
            return YELLOW_LIGHT
        } else if feature.attributes.cases7Per100k > 50 && feature.attributes.cases7Per100k <= 100 {
            //RED Light
            return RED_LIGHT
        } else {
            //DARK RED Light
            return DARK_RED_LIGHT
        }
    }
    
    func getRules(state:Int) -> [String] {
        switch state {
        case GREEN_LIGHT:
            return LanguageManager.getGreenLightRules()
        case YELLOW_LIGHT:
            return LanguageManager.getYellowLightRules()
        case RED_LIGHT:
            return LanguageManager.getRedLightRules()
        default:
            return LanguageManager.getDarkRedLightRules()
        }
    }
}
