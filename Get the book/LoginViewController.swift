//
//  ViewController.swift
//  Get the book
//
//  Created by Pratheeksha Ravindra Naik on 2018-12-04.
//  Copyright © 2018 Hemanth Kasoju. All rights reserved.
//

import UIKit
import os.log

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    // To check if the user is a visitor or a librarian. It will be true for visitor and false for librarian
    var isUser: Bool!
    
    
    // To set default values
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isUser = false
    }
    
    // Called when login button is called
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.isUser = false
        let userEmail = userNameTextField.text;
        let password = passwordTextField.text;
        
        //Check for empty fields
        if((userEmail?.isEmpty)! || (password?.isEmpty)!)
        {
        displayAlertMessage("All feilds are required.");
            return;
        }
        
        // Storing the data
        let userEmailStored = UserDefaults.standard.string(forKey: "userEmail")
        let passwordStored = UserDefaults.standard.string(forKey: "password")
        
        if(userEmail == "admin")
        {
            if(password == "admin")
            {
                self.isUser = false;

                //Login successful
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize();
                
                performSegue(withIdentifier: "librarianView", sender: self)

            }
        }
        else{
            // Popup to show that Librarian incorrect credentials are incorrect
            let myAlert = UIAlertController(title: "Alert", message: "Incorrect Credentials. Try Again.", preferredStyle: .alert);
            // To add a button to the popup
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil);
            
            myAlert.addAction(okAction);
            
            self.present(myAlert, animated: true, completion: nil)
            
        }
        
    }

    // Called when there is a poopup
    func displayAlertMessage(_ userMessage: String){
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert);
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil);

       myAlert.addAction(okAction);

       self.present(myAlert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add backgroung image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "books")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Dismiss the keyboard when the user taps anywhere on the screen
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
       
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // Navigates View controller based on the conditions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        // Navigates to Camera for librarian
        case "librarianView":
            guard let viewController = segue.destination as? QRViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            // Passes the value to next view controller
            viewController.user = self.isUser;
            
        // Navigates to camera for visitor
        case "userView":
            
            self.isUser = true;

            guard let viewController = segue.destination as? QRViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            // Passes the value to next view controller
        viewController.user = self.isUser;
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    

}


