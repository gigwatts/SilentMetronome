//
//  ViewController.swift
//  Silent Metronome
//
//  Created by Dustin Watts on 3/28/15.
//  Copyright (c) 2015 Dustin Watts. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var tempoTextField: UITextField!
    @IBOutlet weak var bgColor: UILabel!
        var opacity: CGFloat = 1
    var i = 20
    @IBOutlet weak var tempoSlider: UISlider!
    @IBOutlet weak var italianName: UILabel!
    @IBOutlet weak var TestLabel: UILabel!
    
    
    @IBOutlet weak var incrementTempoDown: UIButton! //need in order to deactivate button while metronome is running
    @IBOutlet weak var incrementTempoUp: UIButton! //need in order to deactivate button while metronome is running
   
    
    @IBAction func incrementTempoDown(sender: AnyObject) {
        tempo = tempo - 1
    }
    
    
    @IBAction func incrementTempoUp(sender: AnyObject) {
        tempo = tempo + 1
    }
    
    
    var metronomeTimer: NSTimer!
    
    var opacityTimer: NSTimer!
    
    var metronomeIsOn = false
    
    var metronomeSoundPlayer: AVAudioPlayer!
    
    var tempo: NSTimeInterval = 60 {
        didSet {
            tempoTextField.text = String(format: "%.0f", tempo)
            //tempoStepper.value = Double(tempo)
            tempoSlider.value = Float(tempo)
            
            
            //Indicate the classical italian name for the tempo currently being played
            if(Float(tempo) < 24){
                italianName.text = "Larghissimo"
            } else if(Float(tempo) < 45){
                italianName.text = "Grave"
            } else if(Float(tempo) < 50){
                italianName.text = "Lento"
            } else if(Float(tempo) < 55){
                italianName.text = "Largo"
            } else if(Float(tempo) < 60){
                italianName.text = "Larghetto"
            } else if(Float(tempo) < 72){
                italianName.text = "Adagio"
            } else if(Float(tempo) < 80){
                italianName.text = "Adagietto"
            } else if(Float(tempo) < 84){
                italianName.text = "Andantino"
            } else if(Float(tempo) < 90){
                italianName.text = "Andante"
            } else if(Float(tempo) < 96){
                italianName.text = "Andante moderato"
            } else if(Float(tempo) < 108){
                italianName.text = "Moderato"
            } else if(Float(tempo) < 112){
                italianName.text = "Allegretto"
            } else if(Float(tempo) < 120){
                italianName.text = "Allegro Moderato"
            } else if(Float(tempo) < 132){
                italianName.text = "Allegro"
            } else if(Float(tempo) < 144){
                italianName.text = "Vivace"
            } else if(Float(tempo) < 168){
                italianName.text = "Vivacissimo"
            } else if(Float(tempo) < 200){
                italianName.text = "Presto"
            } else if(Float(tempo) >= 200){
                italianName.text = "Prestissimo"
            }
            
            
            
        }
    }

    
    
    @IBOutlet weak var tempoChange: UISlider!
    
    
    @IBAction func tempoChange(sender: UISlider) {
        tempo = NSTimeInterval(tempoSlider.value)   //save new tempo
    }
    
    
    @IBAction func toggleBeat(var toggleMetronomeButton: UIButton) {
        
        // If the metronome is currently on, stop the metronome and change
        // the image of the toggle metronome button to the "Play" image and
        // its tint color to green.
        if metronomeIsOn {
            // Mark the metronome as off.
            metronomeIsOn = false
            
            // Stop the metronome.
            metronomeTimer?.invalidate()
            opacityTimer?.invalidate()
            
            
            
            opacity = 1
            i = 20
            bgColor.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: opacity)
            
            toggleMetronomeButton.setTitle("Drop the Beat", forState: UIControlState.Normal)
            TestLabel.text = "Do it again!"
            
            // Change the toggle metronome button's image to "Play" and tint
            // color to green.
            //            toggleMetronomeButton.setImage(UIImage(named: "Play"), forState: .Normal)
            //            toggleMetronomeButton.tintColor = UIColor.greenColor()
            
            // Enable the metronome stepper.
            //            tempoStepper.enabled = true
            tempoSlider.enabled = true
            
            // Enable editing the tempo text field.
            tempoTextField.enabled = true
            incrementTempoDown.enabled = true
            incrementTempoUp.enabled = true
            
            
            
        }
            
            // If the metronome is currently off, start the metronome and change
            // the image of the toggle metronome button to the "Start" image and
            // its tint color to green
        else {
            // Mark the metronome as on.
            metronomeIsOn = true
            
            // Start the metronome.
            opacity = 0
            let metronomeTimeInterval:NSTimeInterval = 60.0 / (tempo*40)
            metronomeTimer = NSTimer.scheduledTimerWithTimeInterval(metronomeTimeInterval, target: self, selector: Selector("representBeat"), userInfo: nil, repeats: true)
            metronomeTimer?.fire()
            
            // Change the toggle metronome button's image to "Stop" and tint
            // color to red.
            toggleMetronomeButton.setTitle("Stop the Beat", forState: UIControlState.Normal)
            TestLabel.text = "Metronome Running!"
            
            
            //= "Stop the beat." //text = "Stop the beat." //setImage(UIImage(named: "Stop"), forState: .Normal)
            //toggleMetronomeButton.tintColor = UIColor.redColor()
            
            // Disable the metronome stepper.
            //tempoStepper.enabled = false
            
            tempoSlider.enabled = false
            
            // Hide the keyboard
            tempoTextField.resignFirstResponder()
            
            // Disable editing the tempo text field.
            tempoTextField.enabled = false
            incrementTempoDown.enabled = false
            incrementTempoUp.enabled = false
        }

        
    }
    
    
    
    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // Hide the keyboard
//        tempoTextField.resignFirstResponder()
//    }
    
    func playMetronomeSound() {
        //heritage code from original application
        //        let currentTime = CFAbsoluteTimeGetCurrent()
        //        println("Play metronome sound @ \(currentTime)")
        //        metronomeSoundPlayer.play()
        
    }
    
    func representBeat(){
        //decrease opacity of background incrementally with each beat to visually display beat
        opacity = opacity + (CGFloat(i)/200) // 0.1
        bgColor.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: opacity)
        
        //resetting the color opacity to represent an entire cycle being accomplished
        i--
        if(i == -20){
            opacity = 0
            i = 20
            let currentTime = CFAbsoluteTimeGetCurrent()
            println("Play metronome sound @ \(currentTime)")
            //          metronomeSoundPlayer.play()
        }
        
    }
    
    
    // MARK: - UIViewController
    // MARK: Managing the View

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tempo = 120
        
        let metronomeSoundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("metronomeClick", ofType: "mp3")!)
        metronomeSoundPlayer = AVAudioPlayer(contentsOfURL: metronomeSoundURL, error: nil)
        metronomeSoundPlayer.prepareToPlay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
        
    }


}

