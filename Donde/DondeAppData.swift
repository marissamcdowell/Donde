//
//  DondeAppData.swift
//  Donde
//
//  Created by Akia Vongdara on 2/8/15.
//
//

import Foundation
import UIKit
import MapKit

enum Rtype {
    case Mother
    case Father
    case Brother
    case Sister
    case Cousin
    case Friend
    case BestFriend
    case Boyfriend
    case Girlfriend
    case CoWorker
    case Other
}

struct Person {
    //Person is a structure, not a class, so
    //place it wherever you see it fit
    let iCloudID: String
    //    var icon: UIImage
    var relationship: Rtype
    var currentLocation: CLLocation
    
    init(name: String, type : Rtype) {
        self.iCloudID = name
        self.relationship = type
        self.currentLocation = CLLocation(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0))
    }
}

struct User {
    let iCloudID: String
    let name: String
    var currentLocation: CLLocation
    var friends: [Person]
    var dondes: [DondeObj]
    var memos: [Memo]
    
    init(name: String, iCloudID: String) {
        self.iCloudID = iCloudID
        self.name = name
        self.currentLocation = CLLocation(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0))
        self.friends = []
        self.dondes = []
        self.memos = []
    }
}

struct Memo{
    let name: String
    //    var rec: A
    var relate: [Rtype]
}

class DondeAppData {
    var user:User
    
    init(user:User) {
        self.user = user
    }
}