//
//  ViewController.swift
//  NameTheFlag
//
//  Created by Damian Johns on 4/06/2020.
//  Copyright © 2020 Damian Johns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func askQuestion(_ action: UIAlertAction! = nil) {
        countries.shuffle()
        countries.shuffleInPlace()
        button1.setImage(UIImage(named: countries[0]), for: UIControlState())
        button2.setImage(UIImage(named: countries[1]), for: UIControlState())
        button3.setImage(UIImage(named: countries[2]), for: UIControlState())
        
        correctAnswer = Int(arc4random_uniform(3))
        title = countries[correctAnswer].uppercased()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var messageTitle: String
        
        if sender.tag == correctAnswer {
            messageTitle = "Correct"
            score += 1
        } else {
            messageTitle = "Wrong"
            score -= 1
        }
        
        let messageText = "Your score is \(score)"
        
        let ac = UIAlertController(title: messageTitle, message: messageText, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true, completion: nil)
    }
}












