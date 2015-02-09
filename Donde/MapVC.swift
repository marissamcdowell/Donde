//
//  ViewController.swift
//  Donde
//
//  Created by Akia Vongdara on 2/6/15.
//  Copyright (c) 2015 Akia Vongdara. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var theMapView: MKMapView!
    @IBOutlet weak var theSearchBar: UISearchBar!
    
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    //    let aVariable = appdele
    var dondeObj:DondeObj = DondeObj()
    
    var destination:CLLocation = CLLocation(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0))
    var latitude:CLLocationDegrees = 48.399193
    var longitude:CLLocationDegrees = 9.993341
    
    var userLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0))
    var destAddress:String = ""
    var group:String = ""
    var radius:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("loading?")
        
        
        
        // How much to zoom in when app launches
        var latDelta:CLLocationDegrees = 0.05
        var longDelta:CLLocationDegrees = 0.05
        println(self.destAddress)
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        var geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(destAddress, completionHandler: { (placeMarks, error) -> Void in
            
            // Mark location and center
            var placeMark:CLPlacemark = placeMarks.first as CLPlacemark
            var region:MKCoordinateRegion?
            var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(placeMark.location.coordinate, theSpan)
            var newLocation:CLLocationCoordinate2D = placeMark.location.coordinate
            
            self.theMapView.setRegion(theRegion, animated: true)
            
            var theAnnotation = MKPointAnnotation()
            theAnnotation.coordinate = theRegion.center
            theAnnotation.title = self.destAddress
            
            self.theMapView.addAnnotation(theAnnotation)
            
            self.appDelegate.user.dondes.append(DondeObj(destination: placeMark.location, radius: self.radius, group: Rtype.Friend))
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    func mapView(mapView: MKMapView!, viewForOverlay overlay: MKOverlay!) -> MKOverlayView! {
        var circleView:MKCircleView = MKCircleView(overlay: overlay)
        //        circleView. = UIColor(CIColor: CIColor(red: 1.0, green: 0, blue: 0))
        //        circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
        return circleView
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.theSearchBar.delegate = self;
        
        var geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(theSearchBar.text, completionHandler: { (placeMarks, error) -> Void in
            
            // Mark location and center
            var placeMark:CLPlacemark = placeMarks.first as CLPlacemark
            var region:MKCoordinateRegion?
            var newLocation:CLLocationCoordinate2D = placeMark.location.coordinate
            
            region?.center = (placeMark.region as CLCircularRegion).center
            
            // Drop pin
            var annotation:MKPointAnnotation = MKPointAnnotation()
            annotation.setCoordinate(newLocation)
            annotation.title = self.theSearchBar.text
            
            self.theMapView.addAnnotation(annotation)
            
            // Scroll to search result
            var mr:MKMapRect = self.theMapView.visibleMapRect
            var pt:MKMapPoint = MKMapPointForCoordinate(annotation.coordinate)
            mr.origin.x = pt.x - mr.size.width * 0.5;
            mr.origin.y = pt.y - mr.size.height * 0.25;
            self.theMapView .setVisibleMapRect(mr, animated: true)
        })
    }
    
    @IBAction func onConfirmDonde(sender: UIButton) {
        // Start updating user's location to check if the user within radius of the destination
        var user:User = appDelegate.user
        var locationManager:CLLocationManager = appDelegate.locationManager
        
        //        locationManager.delegate = self
        if locationManager.respondsToSelector(Selector("requestWhenInUseAuthorization")){
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startUpdatingLocation()
        
        self.theMapView.showsUserLocation = true
    }
    
    
}

