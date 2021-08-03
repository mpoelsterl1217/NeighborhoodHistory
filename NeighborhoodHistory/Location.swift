//
//  Location.swift
//  NeighborhoodHistory
//
//  Created by Matthew Poelsterl on 8/3/21.
//

import Foundation
import MapKit

class Location: NSObject, MKAnnotation {
    let name: String
    let address: String?
    let coordinate: CLLocationCoordinate2D
    let caption: String?
    let descript: String?
    let tags: [String]?
    
    init(name: String, address: String?, coordinate: CLLocationCoordinate2D, caption: String?, descript: String?, tags: [String]?) {
        self.name = name
        self.address = address
        self.coordinate = coordinate
        self.caption = caption
        self.descript = descript
        self.tags = tags
        
        super.init()
    }
    
    var title: String? {
        return name
    }
    var subtitle: String? {
        return caption
    }
    
}
