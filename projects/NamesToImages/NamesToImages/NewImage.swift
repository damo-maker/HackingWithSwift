//
//  NewImage.swift
//  NamesToImages
//
//  Created by Damian Johns on 1/06/2020.
//  Copyright © 2020 Damian Johns. All rights reserved.
//

import UIKit

class NewImage: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }

}
