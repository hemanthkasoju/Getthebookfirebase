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
    
    
    var isUser: Bool!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isUser = false
    }
    
    
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
                //Login successful
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize();
                
                performSegue(withIdentifier: "librarianView", sender: self)
                
           //     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
                    
                    // Create a variable that you want to send
                   // var isUser : Bool!
                    
                    // Create a new variable to store the instance of PlayerTableViewController
//                    let destinationVC = segue.destination as! QRViewController
//                    destinationVC.isUser = isUser
                    
                }
        }
        
    }

    
    func displayAlertMessage(_ userMessage: String){
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert);
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil);

       myAlert.addAction(okAction);

       self.present(myAlert, animated: true, completion: nil)
    }
    
    
 
       // self.isUser = true

    
    @IBAction func startButtonTapped(_ sender: Any) {
          performSegue(withIdentifier: "userView", sender: self)
//        func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//            if segue.identifier == "userView"
//            {
//                let viewController = segue.destination as! UserViewController
//            }
//        }
        
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Dismiss the keyboard when the user taps anywhere on the screen
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
       
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "librarianView":
//                    os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            guard let viewController = segue.destination as? QRViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
                    isUser = false;
            viewController.user = self.isUser;
            
        case "userView":
            guard let viewController = segue.destination as? QRViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
        isUser = true;
        viewController.user = self.isUser;
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    

}


