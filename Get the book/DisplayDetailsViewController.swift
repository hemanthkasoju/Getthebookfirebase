//
//  displayDetailsViewController.swift
//  Get the book
//
//  Created by Hemanth Kasoju on 2018-12-05.
//  Copyright © 2018 Hemanth Kasoju. All rights reserved.
//

import UIKit
import os.log
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
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func editButtonTapped(_ sender: Any) {
//        self.performSegue(with Identifier: "librarianEdit", sender: self)

        
    }
    // Called when share button is tapped
    @IBAction func shareButtonTapped(_ sender: Any) {
        // To use the applications for sharing text
        let activityController = UIActivityViewController(activityItems: [titleLabel.text!,"Author : ", authorLabel.text!, "Publisher : ", publisherLabel.text!, "Genre : ", genreLabel.text!, "language :", languageLabel.text!, "URL for online access : ", urlLabel.text!, "Location : Archer Library, University of Regina" ], applicationActivities: nil)
        
        present(activityController, animated: true, completion: nil)
    }
    // Used for accessing bookID value passed from the Camera
    var stringRecieved : String!
    var isPresent : Bool!
    // Creates a reference to the firebase database
    var databaseReference : DatabaseReference!
    
    
    override func viewDidLoad() {
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "white")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)

        var titleString = ""
        super.viewDidLoad()
        print(self.stringRecieved)
        
        // Connects the application to the firebase database
         self.databaseReference = Database.database().reference(fromURL : "https://qr-code-bdcfe.firebaseio.com/")
        
        // Retrieves the values from the database and stores in snapshot
        self.databaseReference!.child("books").child(self.stringRecieved).observeSingleEvent(of: .value, with: {
                (snapshot) in
            //Checks if values corresponding to the bookID are found in the database and stoes as a dictionary with corresponding key value pairs
                if let dictionary = snapshot.value as? [String : AnyObject]{
                    
                    // If the bookID is found in the database, displays the corresponding details of the book
                
                        self.titleLabel.text = dictionary["title"] as? String
                        self.authorLabel.text = dictionary["author"] as? String
                        self.genreLabel.text = dictionary["genre"] as? String
                        self.languageLabel.text = dictionary["language"] as? String
                        self.publisherLabel.text = dictionary["publisher"] as? String
                        self.urlLabel.text = dictionary["url"] as? String
                        
            }
                else{
                    
                    // Displays book not found if the bookID is vot found in the database
                    
                    self.titleLabel.text = "Book not found"
                    self.authorLabel.text = ""
                    self.genreLabel.text = ""
                    self.languageLabel.text = ""
                    self.publisherLabel.text = ""
                    self.urlLabel.text = ""
                    if self.shareButton != nil {
                        self.shareButton!.isHidden = true
                    }
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Navigates to edit page if the user clicks on edit and the book already exists in the database
        if segue.identifier == "librarianEdit" {
            guard let viewController = segue.destination as? AddBookViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            // Passes the bookID to edit the details of an existing book
            viewController.bookID = self.stringRecieved
        }
    }
}
