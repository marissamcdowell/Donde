//
//  AppDelegate.swift
//  Donde
//
//  Created by Marissa McDowell on 2/6/15.
//
//

import UIKit
import AVFoundation
import MapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var user:User = User(name: "John Joe", iCloudID: "test@gmail.com")
    var locationManager = CLLocationManager()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        var audioInst = AVAudioSession.sharedInstance()
        
        audioInst.requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                var defaults = NSUserDefaults.standardUserDefaults()
                defaults.setBool(true, forKey: "micAccessAllowed")
            } else {
                println("Permission to record not granted")
                var defaults = NSUserDefaults.standardUserDefaults()
                defaults.setBool(false, forKey: "micAccessAllowed")
            }
        })
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(NSMutableArray(), forKey: "userFriends")
        
        locationManager.delegate = self
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // Updates user location and check if the user is within range of the destination.
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        // self.userLocation = CLLocationCoordinate2D(latitude: locations[0].latitude, longitude: locations[0].longitude)
        var test:CLLocation = CLLocation(latitude: CLLocationDegrees(43.148193), longitude: CLLocationDegrees(-77.613341))
        var userLocation:CLLocationCoordinate2D = (locations[0] as CLLocation).coordinate
        println(userLocation.latitude)
        
        var range:Double = 1000
        println("\(self.user.dondes.count)")
        for (index, element) in enumerate(user.dondes) {
            
            var destination:CLLocation = CLLocation(latitude: CLLocationDegrees(element.destination.coordinate.latitude), longitude: CLLocationDegrees(element.destination.coordinate.longitude))
            var distance:CLLocationDistance = test.distanceFromLocation(destination)
            
            println(test)
            println(destination)
            
            println("\(distance) meters away")
            // Remove donde if found.
            println("\(distance) to \(element.radius)")
            if( distance < element.radius ) {
                println("Destination reached")
                println("removing \(element) at index \(index)")
                
                user.dondes.removeAtIndex(index)
                println("\(user.dondes.count)")
                // If no dondes left, stop tracking the user's location
                if(user.dondes.count == 0) {
                    locationManager.stopUpdatingLocation()
                }
            }
        }
    }
}

