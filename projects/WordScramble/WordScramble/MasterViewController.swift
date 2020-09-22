//
//  MasterViewController.swift
//  WordScramble
//
//  Created by Damian Johns on 5/06/2020.
//  Copyright © 2020 Damian Johns. All rights reserved.
//

import UIKit


class MasterViewController: UITableViewController {

    var objects = [String]()
    var allWords = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()

        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? NSString(contentsOfFile: startWordsPath, encoding: String.Encoding.utf8.rawValue) {
                    allWords = startWords.components(separatedBy: "\n") as [String]
            }
        } else {
            allWords = ["silkworm"]
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MasterViewController.promptForAnswer))
        
        startGame()
    }
    
    func startGame() {
        allWords.shuffle()
        title = allWords[0]
        objects.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] _ in
            let answer = ac.textFields![0] as UITextField
            self.submitAnswer(answer.text!)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true, completion: nil)
    }
    
    func submitAnswer(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if wordIsPossible(lowerAnswer) {
            if wordIsOriginal(lowerAnswer) {
                if wordIsReal(lowerAnswer as NSString) {
                    objects.insert(answer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                } else {
                    let ac = UIAlertController(title: "Word not recognized", message: "You can't just make them up, you know!", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(ac, animated: true, completion: nil)
                }
            } else {
                let ac = UIAlertController(title: "Word used already", message: "Be more original!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(ac, animated: true, completion: nil)
                
            }
        } else {
            let ac = UIAlertController(title: "Word not possible", message: "You can't spell that word from '\(title!.lowercased())'!'", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
            
        }
    }
    
    func wordIsPossible(_ word: String) -> Bool {
        var tempWord = title!.lowercased()
        
        for letter in word.characters {
            if let pos = tempWord.range(of: String(letter)) {
                if pos.isEmpty {
                    return false
                } else {
                    tempWord.remove(at: pos.lowerBound)
                }
            } else {
                return false
            }
        }
        return true
    }


    func wordIsOriginal(_ word: String) -> Bool {
        return !objects.contains(word)
    }
    
    func wordIsReal(_ word: NSString) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.length)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word as String, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }

}

