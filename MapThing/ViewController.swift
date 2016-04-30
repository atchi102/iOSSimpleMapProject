//
//  ViewController.swift
//  MapThing
//
//  Created by Ciauri, Stephen on 4/25/16.
//  Copyright © 2016 Ciauri, Stephen. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController{

    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        // Sample annotation that drops at 0,0 (Near Africa)
        let pin = PointOfInterest(coordinate: CLLocationCoordinate2DMake(0, 0), title: "who wants to be here", subtitle: "no one")
        mapView.addAnnotation(pin)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       
        
        if(NSUserDefaults.standardUserDefaults().tutorialCompleted == false)
        {
            let tutorialVC = self.storyboard?.instantiateViewControllerWithIdentifier("tutorial")
            self.presentViewController(tutorialVC!, animated: false, completion: nil)
        }
        
        
        //TODO: add later
        //checkLocationAuthorizationStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier!{
        case "addNewPin":
            let gr = sender as! UILongPressGestureRecognizer
            let pressLocation = gr.locationInView(mapView)
            let mapCoord = mapView.convertPoint(pressLocation, toCoordinateFromView : mapView)
            
            let nc = segue.destinationViewController as! UINavigationController
            let vc = nc.viewControllers.first! as! NewPinViewController
            
//            vc.map = mapView
            vc.delegate = self
            vc.location = mapCoord
        default:
            break
        }
    }

    @IBAction func didLongPress(sender: UILongPressGestureRecognizer) {
        
        if sender.state == .Began{
            performSegueWithIdentifier("addNewPin", sender: sender)
            
        }

    }

}


extension ViewController: MKMapViewDelegate{
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PointOfInterest{
            var view: MKAnnotationView
            let reuseId = "pin"
            
            if let reusedView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView{
                reusedView.annotation = annotation
                view = reusedView
            }else{
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier:reuseId)
                view.canShowCallout = true
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
                
                //Only works in iOS 8+
                /*
                view.animatesDrop = true
                */
            }
            return view
        }else{
            return nil
        }
    }
    
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        locationManager.stopUpdatingLocation()
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegionMake(userLocation.location!.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
    // Asks for permission to locate the user
    func checkLocationAuthorizationStatus(){
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse{
            mapView.showsUserLocation = true
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    
}

// Implementing the protocol
extension ViewController: NewPinAddedDelegate{
    func addPinToMap(pin: PointOfInterest) {
        mapView.addAnnotation(pin)
    }
}

// We only care about the initial user location. We don't want to monitor their every move... creeper.
extension ViewController: CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        manager.stopUpdatingLocation()
        checkLocationAuthorizationStatus()
    }
}

