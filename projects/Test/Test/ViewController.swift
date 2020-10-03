//
//  ViewController.swift
//  Test
//
//  Created by Damian Johns on 13/06/2020.
//  Copyright © 2020 Damian Johns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseTouchID")
        defaults.set(M_PI, forKey: "Pi")
        
        defaults.set("Paul Hudson", forKey: "Most Awesome Person Ever")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")
        
        let dict = ["Name": "Paul", "Country": "UK"]
        defaults.set(dict, forKey: "SavedDict")
        
        defaults.bool(forKey: "UseTouchID")
        defaults.integer(forKey: "Int")
        
        let loadedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        
        let loadedDict = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

