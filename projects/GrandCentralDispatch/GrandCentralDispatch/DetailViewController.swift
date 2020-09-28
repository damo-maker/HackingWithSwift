//
//  DetailViewController.swift
//  WhitehousePetition
//
//  Created by Damian Johns on 7/06/2020.
//  Copyright © 2020 Damian Johns. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var detailItem: [String: String]!
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let body = detailItem["body"] {
            var html = "<html>"
            html += "<head>"
            html += "<meta name= \"viewport\" content=\"width=device-width, initial-scale = 1\">"
            html += "<style> body {font-size: 150%;} </style>"
            html += "</head>"
            html += "<body>"
            html += body
            html += "</body>"
            html += "</html>"
            
            webView.loadHTMLString(html, baseURL: nil)
            
            navigationController!.setNavigationBarHidden(false, animated:true)
            let myBackButton:UIButton = UIButton() as UIButton
            myBackButton.addTarget(self, action: #selector(DetailViewController.popToRoot(_:)), for: UIControlEvents.touchUpInside)
            myBackButton.setTitle("< back", for: UIControlState())
            myBackButton.setTitleColor(UIColor.gray, for: UIControlState())
            myBackButton.sizeToFit()
            let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
            self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
            
        }
        
    }
    
    @objc func popToRoot(_ sender:UIBarButtonItem){
        self.navigationController!.popToRootViewController(animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }

    }

