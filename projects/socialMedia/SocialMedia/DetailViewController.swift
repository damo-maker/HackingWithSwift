//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Damian Johns on 2/06/2020.
//  Copyright © 2020 Damian Johns. All rights reserved.
//

import Social
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailImageView: UIImageView!

    var detailItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let imageView = detailImageView{
                imageView.image = UIImage(named: detail)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(DetailViewController.shareTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    func shareTapped() {
//        let activity = UIActivityViewController(activityItems: [detailImageView.image!], applicationActivities: [])
//        presentViewController(activity, animated: true, completion: nil)
        
        let social = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        social?.setInitialText("Hello world, buy my app!")
        social?.add(detailImageView.image!)
        social?.add(URL(string: "http://www.photolib.noaa.gov/nssl"))
        present(social!, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

