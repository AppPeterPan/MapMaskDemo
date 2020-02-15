//
//  MaskAnnotation.swift
//  MapDemo
//
//  Created by SHIH-YING PAN on 2020/2/15.
//  Copyright © 2020 SHIH-YING PAN. All rights reserved.
//

import MapKit

extension DateFormatter {
    static let customFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter
    }()
}

class MaskAnnotation : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String? {
        mask?.name
    }
    var subtitle: String? {
        "成人:\(mask?.maskAdult ?? 0) 兒童:\(mask?.maskChild ?? 0)"
    }
    var mask: Mask?
    
    init(feature: MKGeoJSONFeature) {
        
        coordinate = feature.geometry[0].coordinate
        if let data = feature.properties {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                let timeString = try decoder.singleValueContainer().decode(String.self)
                return DateFormatter.customFormatter.date(from: timeString) ?? Date()
            })
            mask = try? decoder.decode(Mask.self, from: data)
        }
    }
    
}
