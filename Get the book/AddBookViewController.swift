//
//  AddBookViewController.swift
//  Get the book
//
//  Created by Hemanth Kasoju on 2018-12-05.
//  Copyright © 2018 Hemanth Kasoju. All rights reserved.
//

import UIKit
import  Firebase

class AddBookViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
  
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var genreText: UITextField!
    @IBOutlet weak var publisherText: UITextField!
    @IBOutlet weak var languageText: UITextField!
    @IBOutlet weak var linkText: UITextField!
    
    @IBAction func saveDetails(_ sender: Any) {
        let uid = "1"
        self.databaseReference.child("books").child(uid).setValue(["title": titleText.text, "author" : authorText.text, "genre" : genreText.text, "publisher" : publisherText.text, "language" : languageText.text])

    }
    
    var isExists: Bool!
    
    
    
    
    let genres = ["Action","Art","Autobiography","Comics","Drama","Fantasy","Fiction","History","Horror","Mystery","Poetry","Romance","Satire","Science"]
    let languages = ["English","French","Spanish","Hindi"]
    
    var databaseReference: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        createGenrePicker()
        createLanguagePicker()
        createToolBar()
//        FirebaseApp.configure()
        //To dismiss the keyboard.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddBookViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        databaseReference = Database.database().reference(fromURL : "https://qr-code-bdcfe.firebaseio.com/")

    }
    
    func createGenrePicker() {
        let genrePicker = UIPickerView()
        genrePicker.delegate = self
        genrePicker.dataSource = self
        genreText.inputView = genrePicker
    }
    func createLanguagePicker() {
        let languagePicker = UIPickerView()
        languagePicker.delegate = self
        languagePicker.dataSource = self
        languageText.inputView = languagePicker
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if genreText.isEditing{
            return genres.count
        }
        else if languageText.isEditing{
            return languages.count
        }
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if genreText.isEditing{
            return genres[row]
        }
        else if languageText.isEditing{
            return languages[row]
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if genreText.isEditing{
            genreText.text = genres[row]
        }
        else if languageText.isEditing{
            languageText.text = languages[row]
        }
    }
    func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddBookViewController.dismissPicker))
        
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        genreText.inputAccessoryView = toolBar
        languageText.inputAccessoryView = toolBar
    }
    @objc func dismissPicker(){
        view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}




