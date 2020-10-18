//
//  ViewController.swift
//  Debugging
//
//  Created by Damian Johns on 24/06/2020.
//  Copyright © 2020 Damian Johns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Debugging methods?
        // print() to the debugger console
        
  /*      for i in 0 ..< 10 {
            print("Number \(i)")
            doStuff()
        }
    }
    
    func doStuff() {
        print("Do stuff")
        doOtherStuff()
    }
    
    func doOtherStuff() {
        print("Other stuff")  */
        
        // Assertions
        
    /*  assert(1 == 1, "Maths failure!")
        assert(1 == 2, "Maths failure!")     */
        
        // Break Points
        
        for i in 1 ... 100 {
            print("Got number \(i)")
            //doStuff()
        }
    }
    
 /*   func doStuff() {
        doOtherStuff()
    }
    
    func doOtherStuff() {
        print("Foo!")
    }  */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

