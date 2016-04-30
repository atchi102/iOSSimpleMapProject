//
//  NewPinViewController.swift
//  MapThing
//
//  Created by Ciauri, Stephen on 4/25/16.
//  Copyright © 2016 Ciauri, Stephen. All rights reserved.
//

import UIKit
import MapKit


class NewPinViewController: UIViewController {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var subtitleField: UITextField!
    
    
    var delegate: NewPinAddedDelegate!
    var location: CLLocationCoordinate2D!
    
    var newAnnotation: PointOfInterest{
        return PointOfInterest(coordinate: location, title: nameField.text!, subtitle: subtitleField.text!)
    }
//    var map: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func donePressed(sender: AnyObject) {
        
        if validateFields(){
            navigationItem.prompt = nil
            dismissViewControllerAnimated(true, completion: {
                self.delegate.addPinToMap(self.newAnnotation)
            })
        }
    }
    
    // Only used when not using delegation pattern
//    private func insertNewAnnotation()-> PointOfInterest{
//        let annotation = PointOfInterest(coordinate: location, title: nameField.text!, subtitle: subtitleField.text!)
//        map.addAnnotation(annotation)
//    }
    
    func validateFields() -> Bool{
        guard nameField.text?.characters.count > 0 else{
            navigationItem.prompt = "Must add a name, you silly head"
            return false
        }
        
        guard subtitleField.text?.characters.count > 0 else{
            navigationItem.prompt = "Must add a subtitle, you silly head"
            return false
        }
        
        return true
    
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

// Delegation is rad
protocol NewPinAddedDelegate{
    func addPinToMap(pin: PointOfInterest)
}


