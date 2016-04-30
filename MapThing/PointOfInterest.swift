//
//  PointOfInterest.swift
//  MapThing
//
//  Created by Ciauri, Stephen on 4/25/16.
//  Copyright © 2016 Ciauri, Stephen. All rights reserved.
//

import UIKit
import MapKit

class PointOfInterest: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    
    
    
    
    

}
