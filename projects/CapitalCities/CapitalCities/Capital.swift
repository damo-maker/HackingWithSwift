//
//  Capital.swift
//  CapitalCities
//
//  Created by Damian Johns on 25/06/2020.
//  Copyright © 2020 Damian Johns. All rights reserved.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
