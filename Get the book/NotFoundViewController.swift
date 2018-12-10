//
//  NotFoundViewController.swift
//  Get the book
//
//  Created by Pratheeksha Ravindra Naik on 2018-12-09.
//  Copyright © 2018 Hemanth Kasoju. All rights reserved.
//

import UIKit

class NotFoundViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // To set the background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "not")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    

}
