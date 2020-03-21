//
//  SecondViewController.swift
//  Good Feeling iOS 13
//
//  Created by han.li on 2020/3/1.
//  Copyright © 2020 jordanlake. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    
    
    
    @IBOutlet weak var leftLED: UIImageView!
    @IBOutlet weak var rightLED: UIImageView!
    
    @IBOutlet weak var timerProgressBar: UIProgressView!
    
    @IBOutlet weak var trainTimeSlider: UISlider!
    @IBOutlet weak var reactTimeSlider: UISlider!
    
    @IBOutlet weak var training: UILabel!
    @IBOutlet weak var trainingTime: UILabel!
    @IBOutlet weak var reactive: UILabel!
    @IBOutlet weak var reactiveTime: UILabel!
    
    var player: AVAudioPlayer?
    
    // prepare for timer
    var agilityTimer = Timer()
    var totalTime      = 0
    var secondsPassed  = 0
    var ledTimer = Timer()
    
    @IBAction func startButton(_ sender: UIButton) {
        //  press start button means re-start
        agilityTimer.invalidate()
        ledTimer.invalidate()
        
        timerProgressBar.progress = 0.0
        secondsPassed = 0
        
        //start timer if user presses start button
        agilityTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        // change text
        // welcomeLabel.text = "GO!"
        
        ledTimer = Timer.scheduledTimer(timeInterval: TimeInterval(reactTimeSlider!.value), target: self, selector: #selector(updateLedTimer), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        // clear the progress bar to zero
        timerProgressBar.progress = 0.0
        
        // invalide the timer if user presses stop button
        agilityTimer.invalidate()
        
        
        // turn off LED
        leftLED.backgroundColor = UIColor.white
        rightLED.backgroundColor = UIColor.white
        
        // change text
        //         welcomeLabel.text = "READY?"
        ledTimer.invalidate()
        player?.stop()
    }
    
    
    // set up timer steps and timer value
    let timerStep: Float = 1
    
    @IBAction func trainTimeSliderButton(_ sender: UISlider) {
        let roundValue = round(sender.value / timerStep ) * timerStep
        let timer = roundValue
        trainingTime.text = "\(timer)分"
        totalTime = Int(roundValue) * 60
        
        // change text
        //        welcomeLabel.text = "READY?"
    }
    
    let intervalStep: Float = 1
    @IBAction func reactTimeSliderButton(_ sender: UISlider) {
        
        let roundvalue = round(sender.value / intervalStep) * intervalStep
        let interval = roundvalue
        reactiveTime.text = "\(interval)秒"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewload okay")
        leftLED.backgroundColor = UIColor.blue
        
        
        trainingTime.text = "0 分"
        reactiveTime.text = "0 秒"
        trainTimeSlider.value = 0.0
        reactTimeSlider.value = 0.0
        
        // change  bar height
        timerProgressBar.transform = timerProgressBar.transform.scaledBy(x: 1, y: 1)
        
        
        // change progress bar to round corner
        timerProgressBar.layer.cornerRadius = 5
        timerProgressBar.clipsToBounds = true
        
        // set LED color
        leftLED.backgroundColor = UIColor.white
        rightLED.backgroundColor = UIColor.white
        
        
    } // end of view didload
    
    
    //***********define a timer update********************/
    @objc func updateTimer() {
        
        if secondsPassed < totalTime {
            secondsPassed = secondsPassed + 1
            print(secondsPassed)
            let  percentage =  Float(secondsPassed) / Float(totalTime)
            timerProgressBar.progress = percentage
            
        } else {
            agilityTimer.invalidate()
            print("Agliity timer is done")
            //print(agilityTimer.isValid)
            playSound(soundName: "alarm_sound")
        }
        
    }
    
    
    //*****************updateLEDTimer ************
    @objc func updateLedTimer () {
        
        if secondsPassed < totalTime {
            secondsPassed = secondsPassed + 1
            randomFlash()
            print(secondsPassed)
        } else {
            ledTimer.invalidate()
            leftLED.backgroundColor = UIColor.darkGray
            rightLED.backgroundColor = UIColor.darkGray
            print("led should be all OFF")
        }
    }
    
    //*********** random flash *********************
    
    func randomFlash () {
        let randomInt = Int.random(in: 0..<2)
        if randomInt == 0 {
            updateLeftLEDColor()
            print("left LED")
        } else {
            updateRightLEDColor()
            print("right LED")
        }
    }
    
    //***********set LED color********************/
    func updateLeftLEDColor() {
        leftLED.backgroundColor = UIColor.cyan
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.leftLED.backgroundColor = UIColor.red
        })
    }
    
    func updateRightLEDColor() {
        rightLED.backgroundColor = UIColor.blue
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.rightLED.backgroundColor = UIColor.red
        })
    }
    
    //***********play sound********************/
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
    
    
} // end of UIview controller




