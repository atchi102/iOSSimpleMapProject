//
//  NSUserDefaults.swift
//  MapThing
//
//  Created by Abigail Atchison on 4/27/16.
//  Copyright © 2016 Ciauri, Stephen. All rights reserved.
//

import Foundation

let TUTORIAL_COMPLETED_KEY = "tutorial_completed"

extension NSUserDefaults{
    
    
    var tutorialCompleted : Bool{
        
        get{
            return self.boolForKey(TUTORIAL_COMPLETED_KEY)
        }
        set{
            self.setBool(newValue, forKey: TUTORIAL_COMPLETED_KEY)
        }
    }
}