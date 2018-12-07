//
//  QRViewController.swift
//  Get the book
//
//  Created by Hemanth Kasoju on 2018-12-05.
//  Copyright © 2018 Hemanth Kasoju. All rights reserved.
//

import UIKit
import os.log
import AVFoundation
import Firebase
import FirebaseDatabase


class QRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate  {

    @IBOutlet weak var square: UIImageView!
    
    var databaseReference : DatabaseReference!
  //  var loginView : LoginViewController
   
      var video = AVCaptureVideoPreviewLayer()
    
  //  var isUser: Bool
    
    
//    init(isUser : Bool) {
//        super.init(coder: Decoder)
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//        self.isUser = false
//
//    }
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseApp.configure()
        self.databaseReference = Database.database().reference(fromURL : "https://qr-code-bdcfe.firebaseio.com/")

        let session = AVCaptureSession()
        
        //Define capture devcie
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        do
        {
            let input = try AVCaptureDeviceInput(device: (captureDevice! ) )
            session.addInput(input)
        }
        catch
        {
            print ("ERROR")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        self.view.bringSubviewToFront(square)
        
        session.startRunning()
        
    }
    

   // func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!)
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        
        if metadataObjects != nil && metadataObjects.count != 0
        {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if object.type == AVMetadataObject.ObjectType.qr
                {
                    var isExists = self.checkIfExists(bookId : object.stringValue!)
                    print(isExists);
                    if isExists {
                            self.performSegue(withIdentifier: "showDetails", sender: self)
                        isExists = false
                    }
                    
                    else
                    {
                         self.performSegue(withIdentifier: "addDetails", sender: self)
                        
                    }
                    
                    
//                    if object.stringValue == "0001"
//                    {
//
//                        let alert = UIAlertController(title: "QR Code", message: "Marlery & Me", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
//                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert:UIAlertAction) -> Void in
//                            self.performSegue(withIdentifier: "showDetails", sender: self)
//                            //self.performSegue(withIdentifier: "showDetails", sender: self)
//
//
//                        }))
//
//                        present(alert, animated: true, completion: nil)
//                    }
//                    else if object.stringValue == "0002"
//                    {
//                        let alert = UIAlertController(title: "QR Code", message: "Five point someone", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
//                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert:UIAlertAction) -> Void in
//                            //self.performSegue(withIdentifier: "existingDetails", sender: self)
//                            self.performSegue(withIdentifier: "showDetails", sender: self)
//
//                        }))
//
//                        present(alert, animated: true, completion: nil)
//
//                    }
//                    else
//                    {
//                        let alert = UIAlertController(title: "QR Code", message: "Five point someone", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
//                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert:UIAlertAction) -> Void in
//                           self.performSegue(withIdentifier: "addDetails", sender: self)
//
//                        }))
//
//                        present(alert, animated: true, completion: nil)
//                    }
                    
                }
            }
        }
    }
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetails"
        {
            let viewController = segue.destination as! DisplayDetailsViewController
        }
    }
    
    func checkIfExists(bookId : String) -> Bool {
        var isPresent = false
        self.databaseReference.child("books").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.hasChild(bookId){
                isPresent = true
            }
            else{
                isPresent = false
            }
            
        })
        return isPresent
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
