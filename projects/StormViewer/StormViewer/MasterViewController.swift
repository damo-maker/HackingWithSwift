//
//  MasterViewController.swift
//  StormViewer
//
//  Created by Damian Johns on 2/06/2020.
//  Copyright © 2020 Damian Johns. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var pictures = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        let docsPath = Bundle.main.resourcePath!
        let fileManager = FileManager.default
        
             do {
                let items = try! fileManager.contentsOfDirectory(atPath: docsPath)
                for item in items as [String] {
                        if item.hasPrefix("nssl") {
                            pictures.append(item)
                            
                    }
             
                   }
                
                  }    // end do statement
        
         print(pictures)
    } // end viewDidLoad
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
            //    let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                
                let detailViewController = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                detailViewController.detailItem = pictures[indexPath.row]
    
            //    controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            //    controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let picture = pictures[indexPath.row]
        cell.textLabel!.text = picture as String
        return cell
    }

}

