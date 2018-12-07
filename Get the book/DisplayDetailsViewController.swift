//
//  displayDetailsViewController.swift
//  Get the book
//
//  Created by Hemanth Kasoju on 2018-12-05.
//  Copyright © 2018 Hemanth Kasoju. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DisplayDetailsViewController: UIViewController {
    
    //Creating outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    var databaseReference : DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
//        FirebaseApp.configure();
        self.databaseReference = Database.database().reference(fromURL : "https://qr-code-bdcfe.firebaseio.com/")
        let bookId = "1"
 self.databaseReference!.child("books").child(bookId).observeSingleEvent(of: .value, with: {
            (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]{
                self.titleLabel.text = dictionary["title"] as? String
                self.authorLabel.text = dictionary["author"] as? String
                self.genreLabel.text = dictionary["genre"] as? String
                self.languageLabel.text = dictionary["language"] as? String
                self.publisherLabel.text = dictionary["publisher"] as? String
                self.urlLabel.text = dictionary["url"] as? String

            }
        }, withCancel: nil)
    }
    
}
