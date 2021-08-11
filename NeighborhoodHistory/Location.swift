//
//  Location.swift
//  NeighborhoodHistory
//
//  Created by Matthew Poelsterl on 8/3/21.
//

import Foundation
import MapKit

class Location: NSObject, MKAnnotation, Codable {
    let name: String
    let address: String?
    let latitude: Double
    let longitude: Double
    let caption: String?
    let descript: String?
    
    init(name: String, address: String?, coordinate: CLLocationCoordinate2D, caption: String?, descript: String?) {
        self.name = name
        self.address = address
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.caption = caption
        self.descript = descript
        
        super.init()
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    var title: String? {
        return name
    }
    var subtitle: String? {
        return caption
    }
    var markerTintColor: UIColor {
        return .orange
    }
    
}
