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
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: [titleLabel.text!,"Author : ", authorLabel.text!, "Publisher : ", publisherLabel.text!, "Genre : ", genreLabel.text!, "language :", languageLabel.text!, "URL for online access : ", urlLabel.text!, "Location : Archer Library, University of Regina" ], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    var stringRecieved : String!
    var isPresent : Bool!
    
    var databaseReference : DatabaseReference!
    
    override func viewDidLoad() {
        var titleString = ""
        super.viewDidLoad()
        print(self.stringRecieved)
         self.databaseReference = Database.database().reference(fromURL : "https://qr-code-bdcfe.firebaseio.com/")
        
//        self.databaseReference.child("books").observeSingleEvent(of: .value, with: { (snapshot) in
//
//            if snapshot.hasChild(self.stringRecieved){
//                self.isPresent = true
//            }
//            else{
//                self.isPresent = false
//            }
//
//        }, withCancel: nil)
       
//        if self.isPresent {
//            self.titleLabel.text = stringRecieved
//            self.authorLabel.text = ""
//            self.genreLabel.text = ""
//            self.languageLabel.text = ""
//            self.publisherLabel.text = ""
//            self.urlLabel.text = ""
//        }
//        else{
        self.databaseReference!.child("books").child(self.stringRecieved).observeSingleEvent(of: .value, with: {
                (snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject]{
//                    self.titleLabel.text = dictionary["title"] as? String
//                    self.authorLabel.text = dictionary["author"] as? String
//                    self.genreLabel.text = dictionary["genre"] as? String
//                    self.languageLabel.text = dictionary["language"] as? String
//                    self.publisherLabel.text = dictionary["publisher"] as? String
//                    self.urlLabel.text = dictionary["url"] as? String
                    if dictionary["title"] as? String != "" && dictionary["title"] as? String != nil {
                        titleString = (dictionary["title"] as? String)!
                    }
                    
                    if titleString == "" {
                        self.titleLabel.text = "Book not found"
                                    self.authorLabel.text = ""
                                    self.genreLabel.text = ""
                                    self.languageLabel.text = ""
                                    self.publisherLabel.text = ""
                                    self.urlLabel.text = ""
                    }
                    else{
                        self.titleLabel.text = dictionary["title"] as? String
                        self.authorLabel.text = dictionary["author"] as? String
                        self.genreLabel.text = dictionary["genre"] as? String
                        self.languageLabel.text = dictionary["language"] as? String
                        self.publisherLabel.text = dictionary["publisher"] as? String
                        self.urlLabel.text = dictionary["url"] as? String
                        
                    }
            }
                else{
                    self.titleLabel.text = "Book not found"
                    self.authorLabel.text = ""
                    self.genreLabel.text = ""
                    self.languageLabel.text = ""
                    self.publisherLabel.text = ""
                    self.urlLabel.text = ""
            }
        }){ (error) in
            print("Error")
        }
    }
    
}
