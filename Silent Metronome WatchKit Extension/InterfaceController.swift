//
//  InterfaceController.swift
//  Silent Metronome WatchKit Extension
//
//  Created by Dustin Watts on 5/7/15.
//  Copyright (c) 2015 Dustin Watts. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    
    @IBOutlet weak var tempoDisplayWatch: WKInterfaceLabel!
    
    
    
    @IBAction func toggleBeatWatchButton() {
        
        tempoDisplayWatch.setText("Tapping!")
    }
    
    
    
}
