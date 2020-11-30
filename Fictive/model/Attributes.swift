//
//  Attributes.swift
//  Fictive
//
//  Created by Prof Ahyox on 18/11/2020.
//

import Foundation
struct Attributes : Decodable {
    var id:Int
    var bundesland:String
    let county:String
    let lastUpdate:String
    let cases7Per100k:Double
    let cases7BundesLandPer100k:Double
    
    enum CodingKeys: String, CodingKey {
        case id = "OBJECTID"
        case bundesland = "BL"
        case county
        case lastUpdate = "last_update"
        case cases7Per100k = "cases7_per_100k"
        case cases7BundesLandPer100k = "cases7_bl_per_100k"
    }
}
