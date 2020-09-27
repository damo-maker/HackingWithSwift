//
//  ViewController.swift
//  SevenSwiftyWords
//
//  Created by Damian Johns on 9/06/2020.
//  Copyright © 2020 Damian Johns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var level = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for subview in view.subviews where subview.tag == 1001 {

                let btn = subview as! UIButton
                letterButtons.append(btn)
                btn.addTarget(self, action: #selector(ViewController.letterTapped(_:)), for: .touchUpInside)
            }
        
        loadLevel()
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
            if let levelContents = try? String(contentsOfFile: levelFilePath) {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutions.append(solutionWord)
                    
                    solutionString += "\(solutionWord.characters.count) letters\n"
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                    
                }
                
            }
            
        }
        
        cluesLabel.text = clueString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        letterBits.shuffle()
        letterButtons.shuffle()
        
        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterBits.count {
                letterButtons[i].setTitle(letterBits[i], for: UIControlState())
            }
        }
    }
    
    func letterTapped(_ btn: UIButton) {
        currentAnswer.text = currentAnswer.text! + btn.titleLabel!.text!
        activatedButtons.append(btn)
        btn.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitTapped(_ sender: AnyObject) {
        if let solutionPosition = solutions.index(of: currentAnswer.text!) {
            activatedButtons.removeAll()
            
            var splitClues = answersLabel.text!.components(separatedBy: "\n")
            splitClues[solutionPosition] = currentAnswer.text!
            answersLabel.text = splitClues.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true, completion: nil)
            }
        }
    }
    
    func levelUp(_ action: UIAlertAction!) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        
        for btn in letterButtons {
            btn.isHidden = false
        }
    }

    @IBAction func clearTapped(_ sender: AnyObject) {
        currentAnswer.text = ""
        
        for btn in activatedButtons {
            btn.isHidden = false
        }
        
        activatedButtons.removeAll()
    }
}

