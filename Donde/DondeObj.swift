//
//  DondeObj.swift
//  Donde
//
//  Created by Akia Vongdara on 2/8/15.
//
//

import Foundation
import MapKit

class DondeObj {
    var destination:CLLocation
    var radius:Double
    var group: Rtype
    
    init(destination:CLLocation, radius:Double, group:Rtype) {
        self.destination = destination
        self.radius = radius
        self.group = group
    }
    
    init() {
        self.radius = 0
        self.group = Rtype.Friend
        self.destination = CLLocation(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0))
    }
}