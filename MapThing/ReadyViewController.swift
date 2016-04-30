//
//  ReadyViewController.swift
//  MapThing
//
//  Created by Abigail Atchison on 4/27/16.
//  Copyright © 2016 Ciauri, Stephen. All rights reserved.
//

import UIKit

class ReadyViewController:UIViewController, Indexable
{
    @IBAction func DoneClicked(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().tutorialCompleted = true;
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var index = 2
}
