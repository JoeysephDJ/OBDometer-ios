//
//  ViewController.swift
//  O-B-Dometer
//
//  Created by Connor Critchley on 4/1/23.
//

import UIKit
import CoreLocation
import CoreBluetooth
import MapKit
import FirebaseCore
import FirebaseAuth

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, CBCentralManagerDelegate{
    
    @IBOutlet var testText:UITextView!
    @IBOutlet var mapView:MKMapView!
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var centralManager: CBCentralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 300
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            testText.text += ("Bluetooth is powered on\n")
            // Start scanning for devices here
        } else {
            testText.text += ("Bluetooth is not available\n")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral.name != nil {
            testText.text += ("Discovered device: \(peripheral.name!)")
        }
    }
    
    func mapView (_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let zoomArea = MKCoordinateRegion(center: self.mapView.userLocation.coordinate, span: MKCoordinateSpan (latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.mapView.setRegion (zoomArea, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            AppDelegate.shared().latitude = "\(newLocation.coordinate.latitude)"
            AppDelegate.shared().longitude = "\(newLocation.coordinate.longitude)"
            testText.text = "Latitute: " + AppDelegate.shared().latitude + "\nLongitute: " + AppDelegate.shared().longitude + "\n"
            geocoder.reverseGeocodeLocation(newLocation, completionHandler: {(placemarks, error) -> Void in
                if error != nil {
                    print("Failed to geolocate.")
                    return
                }
                //handle returned placemark
                if let placemarks = placemarks, let placemark = placemarks.first {
                    print(placemark.administrativeArea!)
                    let state = placemark.administrativeArea!
                    self.testText.text += placemark.administrativeArea! + "\n"
                    //if no currentState
                    if (AppDelegate.shared().currentState == "") {
                        //currentState = placemark state
                        AppDelegate.shared().currentState = placemark.administrativeArea!
                    } else if (state != AppDelegate.shared().currentState) {
                        //if placemark state is different from current state,
                        //currentState is now Old state, and currentState becomes placemark state
                        AppDelegate.shared().oldState = AppDelegate.shared().currentState
                        AppDelegate.shared().currentState = state
                    }
                }
                else {
                    print("No State Found")
                }
            })
        }
        
    }
    
}

