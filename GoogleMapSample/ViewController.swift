//
//  ViewController.swift
//  GoogleMapSample
//
//  Created by Mohsin on 27/10/2015.
//  Copyright (c) 2015 Mohsin. All rights reserved.
//

import UIKit
import GoogleMaps


class ViewController: UIViewController , CLLocationManagerDelegate{

    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var camera = GMSCameraPosition.cameraWithLatitude(-33.86,
            longitude: 151.20, zoom: 6)

        self.mapView.camera = camera
        self.mapView.myLocationEnabled = true
        
        
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        
        self.getUserLocation()
    }
    
    
    func getUserLocation(){
        // For use in foreground
        if (self.locationManager.respondsToSelector(Selector("requestWhenInUseAuthorization"))) {
            self.locationManager.requestWhenInUseAuthorization()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        else{
            let alert = UIAlertView(title: "Alert", message: "GPS is Off", delegate: self, cancelButtonTitle: "Ok")
            alert.show()
        }
    }
    
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        println("locations = \(locValue.latitude) \(locValue.longitude)")
        
        
        var camera = GMSCameraPosition.cameraWithLatitude(locValue.latitude,
            longitude: locValue.longitude, zoom: 14)
        
        self.mapView.camera = camera
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

