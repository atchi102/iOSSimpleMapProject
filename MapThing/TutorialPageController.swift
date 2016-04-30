//
//  TutorialPageController.swift
//  MapThing
//
//  Created by Abigail Atchison on 4/27/16.
//  Copyright © 2016 Ciauri, Stephen. All rights reserved.
//

import UIKit

class TutorialPageController: UIPageViewController, UIPageViewControllerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        let welcomeVC = self.storyboard?.instantiateViewControllerWithIdentifier("welcome")
        
        self.setViewControllers([welcomeVC!], direction: .Forward, animated: true, completion: nil)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController currentViewController: UIViewController) -> UIViewController? {
        
        let currentIndex = (currentViewController as! Indexable).index
        
        switch currentIndex {
        case 0:
            return self.storyboard?.instantiateViewControllerWithIdentifier("howto")
        case 1:
            return self.storyboard?.instantiateViewControllerWithIdentifier("ready")
        case 2:
            return nil
        default:
            return nil
        }
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController currentViewController: UIViewController) -> UIViewController? {
        
        let currentIndex = (currentViewController as! Indexable).index
        
        switch currentIndex {
        case 0:
            return nil
        case 1:
            return self.storyboard?.instantiateViewControllerWithIdentifier("welcome")
        case 2:
            return self.storyboard?.instantiateViewControllerWithIdentifier("howto")
        default:
            return nil
        }
    }

}
