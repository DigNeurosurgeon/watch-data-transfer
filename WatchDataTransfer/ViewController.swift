//
//  ViewController.swift
//  WatchDataTransfer
//
//  Created by Pieter Kubben on 03-01-16.
//  Copyright © 2016 DigitalNeurosurgeon.com. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    @IBOutlet weak var dataTextField: UITextView!
    var watchDataText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConnectivity()
        populateDataTextField()
    }
    
    
    // MARK:- Prepare UI


    @IBAction func onDataSourceValueChanged(sender: AnyObject) {
        switch sender.selectedSegmentIndex {
            case 0:
                populateDataTextField()
            case 1:
                let emptyText = "Waiting for Apple Watch data"
                dataTextField.text = watchDataText.characters.count > 0 ? watchDataText : emptyText            
            default:
                dataTextField.text = "No valid data found"
        }
        
    }
    
    
    private func populateDataTextField() {
        dataTextField.text = RandomData.generateString(10)
    }
    
    
    // MARK:- Apple Watch connection
    
    
    private func setupConnectivity() {
        
        if WCSession.isSupported() {
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
            print("WCSession is supported")
            
            if !session.paired {
                print("Apple Watch is not paired")
            }
            
            if !session.watchAppInstalled {
                print("Apple Watch app is not installed")
            }
        } else {
            print("Apple Watch connectivity is not supported on this device")
        }
    }
    
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        watchDataText = message["data"] as! String
        
        dispatch_async(dispatch_get_main_queue() ) {
            self.dataTextField.text = self.watchDataText
        }
        
        let replyValues = ["status": "Data sent!"]
        replyHandler(replyValues)
    }
    

}



