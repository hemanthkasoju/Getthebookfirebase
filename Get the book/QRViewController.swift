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


  //  @IBOutlet weak var square: UIImageView!
    
      //var video = AVCaptureVideoPreviewLayer()
    var video: AVCaptureVideoPreviewLayer!
    var captureSession: AVCaptureSession!
    var value: String!
    var user: Bool!
    var databaseReference : DatabaseReference!
    var isExists: Bool!
    


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
//        FirebaseApp.configure()
        
        print(user)
        
        self.databaseReference = Database.database().reference(fromURL : "https://qr-code-bdcfe.firebaseio.com/")

        captureSession = AVCaptureSession()

        //Define capture devcie
 let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        var input: AVCaptureDeviceInput!
        
        do {
            input = try AVCaptureDeviceInput(device: captureDevice! ) }
        catch {
            print("error")
        }
        
        if (captureSession.canAddInput(input!)){
            captureSession.addInput(input!)
            }
        else{
            print("Error");
        }

//        var captureDevice: AVCaptureDevice!
//        let captureDeviceInput: AVCaptureDeviceInput?

//        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
//        let captureDeviceInput: AVCaptureDeviceInput
//
//        do {
//           captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice!)
//        } catch {
//            return
//        }
//
//        if (session.canAddInput(captureDeviceInput)) {
//            session.addInput(captureDeviceInput)
//        } else {
//            print("Error")
//            return;
//        }
////        do {
////            captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
////
////            if let captureDeviceInput = captureDeviceInput
////            {
////                if session.canAddInput(captureDeviceInput) {
////                    session.addInput(captureDeviceInput)
////                }
////            }
////        }
////
////        catch
////        {
////            print ("ERROR")
////        }

        let output = AVCaptureMetadataOutput()
        if (captureSession.canAddOutput(output)) {
            captureSession.addOutput(output)

        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)

        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        } else {
            print("Error")
        }

        video = AVCaptureVideoPreviewLayer(session: captureSession)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)

     //   self.view.bringSubviewToFront(square)

        captureSession.startRunning()

    }


//    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!)

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection)
    {

        
        var isDetected = false;
        
        if metadataObjects != nil && metadataObjects.count != 0
        {
            
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if object.type == AVMetadataObject.ObjectType.qr && !isDetected
                {
                    isDetected = true
                    value = object.stringValue
                    print(object.stringValue);
                    self.isExists  = checkIfExists(bookId: object.stringValue!)
//                    let alert = UIAlertController(title: "QR Code", message: object.stringValue , preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
//                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert:UIAlertAction) -> Void in
                        self.performSegue(withIdentifier: "showDetails", sender: self)
//
//                    }))
//
                    
                        
                    
//                    func prepareForSegue(segue: UIStoryboardSegue, sender: Any?) {
//                                if segue.identifier == "existingDetails"
//                                {
//                                    let viewController = segue.destination as! DisplayDetailsViewController
//                                }
//                        }
                
                    
                }
                    //

//                    var isExists = self.checkIfExists(bookId : object.stringValue!)
//                    print(isExists);
//                    if isExists {
//                            self.performSegue(withIdentifier: "showDetails", sender: self)
//                        isExists = false
//                    }
//
//                    else
//                    {
//                         self.performSegue(withIdentifier: "addDetails", sender: self)
//
//                    }


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
        print(isPresent)
        return isPresent
    }
    
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showDetails"
//        {
//            let viewController = segue.destination as! DisplayDetailsViewController
//        }
//    }
//

    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//}

//class QRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
//    var databaseReference : DatabaseReference!
//    var loginView : LoginViewController
//    var captureSession: AVCaptureSession!
//    var previewLayer: AVCaptureVideoPreviewLayer!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        FirebaseApp.configure()
//        //        self.databaseReference = Database.database().reference(fromURL : "https://qr-code-bdcfe.firebaseio.com/")
//
//        view.backgroundColor = UIColor.black
//        captureSession = AVCaptureSession()
//
//        let videoCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)
//        let videoInput: AVCaptureDeviceInput
//
//        do {
//            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice!)
//        } catch {
//            return
//        }
//
//        if (captureSession.canAddInput(videoInput)) {
//            captureSession.addInput(videoInput)
//        } else {
//            failed();
//            return;
//        }
//
//        let metadataOutput = AVCaptureMetadataOutput()
//
//        if (captureSession.canAddOutput(metadataOutput)) {
//            captureSession.addOutput(metadataOutput)
//
//            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//            metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.ean8, AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.pdf417]
//        } else {
//            failed()
//            return
//        }
//
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
//        previewLayer.frame = view.layer.bounds;
//        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill;
//        view.layer.addSublayer(previewLayer);
//
//        captureSession.startRunning();
//    }
//
//    func failed() {
//        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
//        captureSession = nil
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        if (captureSession?.isRunning == false) {
//            captureSession.startRunning();
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        if (captureSession?.isRunning == true) {
//            captureSession.stopRunning();
//        }
//    }
//
//    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection)   {
////        captureSession.stopRunning()
////
////        if let metadataObject = metadataObjects.first {
////            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
////
////            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
////            found(code: readableObject.stringValue!);
//
//            if metadataObjects != nil && metadataObjects.count != 0
//                    {
//                       if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
//                        {
//                            if object.type == AVMetadataObject.ObjectType.qr
//                            {
//                               let alert = UIAlertController(title: "QR Code", message: object.stringValue , preferredStyle: .alert)
//                               alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
//                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert:UIAlertAction) -> Void in
//                                      self.performSegue(withIdentifier: "existingDetails", sender: self)
//                                   }))
//
//        }
//                        }
//        }
//
//
//        dismiss(animated: true)
//
//    }
//
//    func found(code: String) {
//        print(code)
//    }
//
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
//
//}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    super.prepare(for: segue, sender: sender)
//    var isExists = self.checkIfExists(bookId :  value!)
    //                    print(isExists);
    //                    if isExists {
    //                            self.performSegue(withIdentifier: "showDetails", sender: self)
    //                        isExists = false
    //                    }
    //
    //                    else
    //                    {
    //                         self.performSegue(withIdentifier: "addDetails", sender: self)
    //
    //                    }
    if self.user{
        if self.isExists {
            if segue.identifier == "showDetails" {
            guard let viewController = segue.destination as? DisplayDetailsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
                
            }
                viewController.stringRecieved = value;
            }
            
        }
        else {
            guard let viewController = segue.destination as? DisplayDetailsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            viewController.stringRecieved = "Book Not Found";
            print("Book not found")
        }
               
}
   
        
   
//    case "AddItem":
//        os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        
  
//        guard let viewController = segue.destination as? DisplayDetailsViewController else {
//            fatalError("Unexpected destination: \(segue.destination)")
//        }
//
//        viewController.stringRecieved = value;
//
//    default:
//        fatalError("Unexpected Segue Identifier; \(segue.identifier)")
//    }
//        }
//    }
//    else{
//        switch(segue.identifier ?? "") {
//
//
//            //    case "AddItem":
//            //        os_log("Adding a new meal.", log: OSLog.default, type: .debug)
//
//        case "showDetails":
//            guard let viewController = segue.destination as? DisplayDetailsViewController else {
//                fatalError("Unexpected destination: \(segue.destination)")
//            }
//
//            viewController.stringRecieved = value;
//
//        default:
//            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
//        }
        
            }
            

}
