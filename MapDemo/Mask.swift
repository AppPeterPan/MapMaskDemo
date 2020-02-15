//
//  Mask.swift
//  MapDemo
//
//  Created by SHIH-YING PAN on 2020/2/15.
//  Copyright © 2020 SHIH-YING PAN. All rights reserved.
//

import Foundation

struct Mask: Decodable {
    let name: String
    let phone: String
    let address: String
    let maskAdult: Int
    let maskChild: Int
    let updated: Date
    let available: String
    let note: String
    let customNote: String
    let website: String
    let county: String
    let town: String
    let cunli: String
    let servicePeriods: String
}
