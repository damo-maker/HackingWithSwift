//
//  ViewController.swift
//  Animation
//
//  Created by Damian Johns on 18/06/2020.
//  Copyright © 2020 Damian Johns. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    var imageView: UIImageView!
    var currentAnimation = 0
    

    @IBOutlet weak var tap: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapped(_ sender: AnyObject) {
        tap.isHidden = false
        
        //UIView.animateWithDuration(1, delay: 0, options: [],
        UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: [], animations: { [unowned self] in
            
            switch self.currentAnimation {
            case 0:
                self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                break
                
            case 1:
                self.imageView.transform = CGAffineTransform.identity

            case 2:
                self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
                
            case 3:
                self.imageView.transform = CGAffineTransform.identity
                
            case 4:
                self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
                
            case 5:
                self.imageView.transform = CGAffineTransform.identity
                
            case 6:
                self.imageView.alpha = 0.1
                self.imageView.backgroundColor = UIColor.green
                
            case 7:
                self.imageView.alpha = 1
                self.imageView.backgroundColor = UIColor.clear
                
            default:
                break
            }
            
        }) { [unowned self] (finished: Bool) in
                self.tap.isHidden = false
                
        }
        
        currentAnimation += 1
        
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }

}

