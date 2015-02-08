//
//  DondeUtils.swift
//  Donde
//
//  Created by Marissa McDowell on 2/7/15.
//
//

import UIKit

let dondeGreenColor:UIColor = UIColor(
    red: 46.0/255.0,
    green: 204.0/255.0,
    blue: 113.0/255.0,
    alpha: 1.0)

let dondeAsphaltColor:UIColor = UIColor(
    red: 26.0/255.0,
    green: 36.0/255.0,
    blue: 47.0/255.0,
    alpha: 1.0)

let dondeCloudColor:UIColor = UIColor(
    red: 236.0/255.0,
    green: 240.0/255.0,
    blue: 241.0/255.0,
    alpha: 1.0)

class DondeUtils: NSObject {
    
    func doesUserHaveFriends() -> Bool {
        var defaults = NSUserDefaults.standardUserDefaults()
        return defaults.boolForKey("hasFriends")
    }
    
    func setUserHasFriends(value:Bool){
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(value, forKey: "hasFriends")
    }
    
    func addFriend(friendDict:NSDictionary){
        var defaults = NSUserDefaults.standardUserDefaults()
        var friendsArray:NSMutableArray = defaults.objectForKey("userFriends")?.mutableCopy() as NSMutableArray
        println("size of friends 1: \(friendsArray)")
        friendsArray.addObject(friendDict)
        println("size of friends 2: \(friendsArray)")        
    }
    
    
}
