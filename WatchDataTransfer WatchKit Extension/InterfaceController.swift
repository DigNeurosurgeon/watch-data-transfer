//
//  InterfaceController.swift
//  WatchDataTransfer WatchKit Extension
//
//  Created by Pieter Kubben on 03-01-16.
//  Copyright © 2016 DigitalNeurosurgeon.com. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {

    @IBOutlet var statusLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        statusLabel.setHidden(true)
    }

    @IBAction func onRandomDataButton() {        
        statusLabel.setHidden(true)
        let session = WCSession.defaultSession()
        
        if session.reachable {
            let dataValues = ["data": RandomData.generateString(10)]
            session.sendMessage(dataValues,
                replyHandler: { reply in
                    self.statusLabel.setHidden(false)
                    self.statusLabel.setText(reply["status"] as? String)
                }, errorHandler: { error in
                    self.statusLabel.setText("Error: \(error)")
            })
        }
        

    }
    


}
