//
//  Constants.swift
//  Fictive
//
//  Created by Prof Ahyox on 18/11/2020.
//

import Foundation
import UIKit

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
let STORY_BOARD = UIStoryboard(name: "Main", bundle: nil)
let USER_PREF = UserDefaults.standard

let SELECTED_COUNTY = "county"
let CURRENT_CASE = "case"

let REPEAT_TIME_IN_SEC:Double = 600 //10 * 60

let GREEN_LIGHT = 1
let YELLOW_LIGHT = 2
let RED_LIGHT = 3

let BASE_URL = "https://services7.arcgis.com/"
let FEATURE_SERVIEC_QUERY_PATH = "mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?"
