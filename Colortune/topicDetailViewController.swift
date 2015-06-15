//
//  topicDetailViewController.swift
//  Patterns
//
//  Created by Anna Torlen on 2/28/15.
//  Copyright (c) 2015 Anna Torlen. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class topicDetailViewController : UIViewController, UIScrollViewDelegate {
    
    //midi
    var engine:AVAudioEngine!
    var playerNode:AVAudioPlayerNode!
    var mixer:AVAudioMixerNode!
    var sampler:AVAudioUnitSampler!
    var buffer:AVAudioPCMBuffer!
    /// soundbanks are either dls or sf2. see http://www.sf2midi.com/
    var soundbank:NSURL!
    let melodicBank:UInt8 = UInt8(kAUSampler_DefaultMelodicBankMSB)
    /// general midi number for marimba
    let gmTuba:UInt8 = 59 //red
    let gmMutedTrumpet:UInt8 = 60 //coral
    let gmTubularBells:UInt8 = 15 //orange
    let gmTrumpet:UInt8 = 57 //gold
    let gmViolin:UInt8 = 41 //yellow //light green //green
    let gmFlute:UInt8 = 74 //turq
    let gmCello:UInt8 = 42 //blue
    let gmPercussiveOrgan:UInt8 = 18 //indigo
    let gmEnglishHorn:UInt8 = 70 //violet
    let gmBassoon:UInt8 = 71 //magenta
    let gmViola:UInt8 = 42 //
    
    
    var sound:Sound = Sound()
    
    
    @IBOutlet var topicLabel: UILabel!
    
    @IBOutlet var topicDefinitionLabel: UILabel!
    
    
    var topic = "A"
    var topicDefinition = "Kandinsky Art"
    
    //var image : UIImage = UIImage(named:"kandinsky.png")!
   
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    
   var image : UIImage? = nil
    
    override func viewDidLoad() {
        self.topicLabel.text = self.topic
        self.topicDefinitionLabel.text = self.topicDefinition
        
        self.scrollView.minimumZoomScale = 1
        self.scrollView.maximumZoomScale = 50
        self.scrollView.delegate = self
        self.imageView.image = self.image
        
        initAudioEngine()
        sound.toggleAVPlayer()
        

    }
    
   func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return nil
}
    
    //added buttons

    //Fifth Octave:
    
    @IBAction func redButton(sender: AnyObject) {
        self.topicDefinitionLabel.text = "C Tuba"
        loadTuba()
        self.sampler.startNote(60, withVelocity: 64, onChannel: 0)
        let coloredSquare = UIView()
        coloredSquare.backgroundColor = UIColor.redColor()
        coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
        self.view.addSubview(coloredSquare)
        UIView.animateWithDuration(1.0, animations: {
            coloredSquare.backgroundColor = UIColor.redColor()
            coloredSquare.frame = CGRect(x: 320-10, y: 350-0, width: 10, height: 50)
            }, completion: { finished in
                self.sampler.stopNote(60, onChannel: 0)
                coloredSquare.backgroundColor = UIColor.clearColor()
                coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
                
        })
    }
    
    @IBAction func goldButton(sender: AnyObject) { //light orange
        self.topicDefinitionLabel.text = "C# Trumpet"
        loadMutedTrumpet()
        self.sampler.startNote(61, withVelocity: 64, onChannel: 0)
        let coloredSquare = UIView()
        coloredSquare.backgroundColor = UIColor.orangeColor()
        coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
        self.view.addSubview(coloredSquare)
        UIView.animateWithDuration(1.0, animations: {
            coloredSquare.backgroundColor = UIColor.yellowColor()
            coloredSquare.frame = CGRect(x: 320-10, y: 350-0, width: 10, height: 50)
            }, completion: { finished in
                self.sampler.stopNote(61, onChannel: 0)
                coloredSquare.backgroundColor = UIColor.clearColor()
                coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
                
        })
        
    }
    
    @IBAction func coralButton(sender: AnyObject) { //orange button
        self.topicDefinitionLabel.text = "D Tubular Bells"
        loadTubularBells()
        self.sampler.startNote(62, withVelocity: 64, onChannel: 0)
        let coloredSquare = UIView()
        coloredSquare.backgroundColor = UIColor.redColor()
        coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
        self.view.addSubview(coloredSquare)
        UIView.animateWithDuration(1.0, animations: {
            coloredSquare.backgroundColor = UIColor.orangeColor()
            coloredSquare.frame = CGRect(x: 320-10, y: 350-0, width: 10, height: 50)
            }, completion: { finished in
                self.sampler.stopNote(62, onChannel: 0)
                coloredSquare.backgroundColor = UIColor.clearColor()
                coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
                
        })
        
        
    }
    
    
    @IBAction func orangeButton(sender: AnyObject) { //gold button
        self.topicDefinitionLabel.text = "D# Trumpet"
        loadTrumpet()
        self.sampler.startNote(63, withVelocity: 64, onChannel: 0)
        let coloredSquare = UIView()
        coloredSquare.backgroundColor = UIColor.orangeColor()
        coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
        self.view.addSubview(coloredSquare)
        UIView.animateWithDuration(1.0, animations: {
            coloredSquare.backgroundColor = UIColor.orangeColor()
            coloredSquare.frame = CGRect(x: 320-10, y: 350-0, width: 10, height: 50)
            }, completion: { finished in
                self.sampler.stopNote(63, onChannel: 0)
                coloredSquare.backgroundColor = UIColor.clearColor()
                coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
                
        })
        
        
    }

    
    
    @IBAction func yellowButton(sender: AnyObject) {
        self.topicDefinitionLabel.text = "E Violin"
        loadViolin()
        self.sampler.startNote(64, withVelocity: 64, onChannel: 0)
        let coloredSquare = UIView()
        coloredSquare.backgroundColor = UIColor.yellowColor()
        coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
        self.view.addSubview(coloredSquare)
        UIView.animateWithDuration(1.0, animations: {
            coloredSquare.backgroundColor = UIColor.yellowColor()
            coloredSquare.frame = CGRect(x: 320-10, y: 350-0, width: 10, height: 50)
            }, completion: { finished in
                self.sampler.stopNote(64, onChannel: 0)
                coloredSquare.backgroundColor = UIColor.clearColor()
                coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
                
        })

    }
    
    @IBAction func lightgreen(sender: AnyObject) {
        self.topicDefinitionLabel.text = "F Violin"
        loadViolin()
        self.sampler.startNote(65, withVelocity: 64, onChannel: 0)
        let coloredSquare = UIView()
        coloredSquare.backgroundColor = UIColor.yellowColor()
        coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
        self.view.addSubview(coloredSquare)
        UIView.animateWithDuration(1.0, animations: {
            coloredSquare.backgroundColor = UIColor.greenColor()
            coloredSquare.frame = CGRect(x: 320-10, y: 350-0, width: 10, height: 50)
            }, completion: { finished in
                self.sampler.stopNote(65, onChannel: 0)
                coloredSquare.backgroundColor = UIColor.clearColor()
                coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
                
        })

    }
    
    
    @IBAction func greenButton(sender: AnyObject) {
        self.topicDefinitionLabel.text = "F# Violin"
        loadViolin()
        self.sampler.startNote(66, withVelocity: 64, onChannel: 0)
        let coloredSquare = UIView()
        coloredSquare.backgroundColor = UIColor.greenColor()
        coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
        self.view.addSubview(coloredSquare)
        UIView.animateWithDuration(1.0, animations: {
            coloredSquare.backgroundColor = UIColor.greenColor()
            coloredSquare.frame = CGRect(x: 320-10, y: 350-0, width: 10, height: 50)
            }, completion: { finished in
                self.sampler.stopNote(66, onChannel: 0)
                coloredSquare.backgroundColor = UIColor.clearColor()
                coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
                
        })


}
    
    
    @IBAction func turqButton(sender: AnyObject) {
        self.topicDefinitionLabel.text = "G Flute"
        loadFlute()
        self.sampler.startNote(67, withVelocity: 64, onChannel: 0)
        let coloredSquare = UIView()
        coloredSquare.backgroundColor = UIColor.blueColor()
        coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
        self.view.addSubview(coloredSquare)
        UIView.animateWithDuration(1.0, animations: {
            coloredSquare.backgroundColor = UIColor.greenColor()
            coloredSquare.frame = CGRect(x: 320-10, y: 350-0, width: 10, height: 50)
            }, completion: { finished in
                self.sampler.stopNote(67, onChannel: 0)
                coloredSquare.backgroundColor = UIColor.clearColor()
                coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
                
        })
    }
    
    
    @IBAction func blueButton(sender: AnyObject) {
        self.topicDefinitionLabel.text = "G# Cello"
        loadCello()
        self.sampler.startNote(68, withVelocity: 64, onChannel: 0)
        let coloredSquare = UIView()
        coloredSquare.backgroundColor = UIColor.blueColor()
        coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
        self.view.addSubview(coloredSquare)
        UIView.animateWithDuration(1.0, animations: {
            coloredSquare.backgroundColor = UIColor.blueColor()
            coloredSquare.frame = CGRect(x: 320-10, y: 350-0, width: 10, height: 50)
            }, completion: { finished in
                self.sampler.stopNote(68, onChannel: 0)
                coloredSquare.backgroundColor = UIColor.clearColor()
                coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
                
        })
    }
    
    
    @IBAction func indigoButton(sender: AnyObject) {
        self.topicDefinitionLabel.text = "A Percussive Organ"
        loadPercussiveOrgan()
        self.sampler.startNote(69, withVelocity: 64, onChannel: 0)
        let coloredSquare = UIView()
        coloredSquare.backgroundColor = UIColor.blueColor()
        coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
        self.view.addSubview(coloredSquare)
        UIView.animateWithDuration(1.0, animations: {
            coloredSquare.backgroundColor = UIColor.purpleColor()
            coloredSquare.frame = CGRect(x: 320-10, y: 350-0, width: 10, height: 50)
            }, completion: { finished in
                self.sampler.stopNote(69, onChannel: 0)
                coloredSquare.backgroundColor = UIColor.clearColor()
                coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
                
        })
        
        
    }
    
    
    @IBAction func violetButton(sender: AnyObject) {
        self.topicDefinitionLabel.text = "A# English Horn"
        loadEnglishHorn()
        self.sampler.startNote(70, withVelocity: 64, onChannel: 0)
        let coloredSquare = UIView()
        coloredSquare.backgroundColor = UIColor.purpleColor()
        coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
        self.view.addSubview(coloredSquare)
        UIView.animateWithDuration(1.0, animations: {
            coloredSquare.backgroundColor = UIColor.purpleColor()
            coloredSquare.frame = CGRect(x: 320-10, y: 350-0, width: 10, height: 50)
            }, completion: { finished in
                self.sampler.stopNote(70, onChannel: 0)
                coloredSquare.backgroundColor = UIColor.clearColor()
                coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
                
        })
    }
    
    
    
    @IBAction func magentaButton(sender: AnyObject) {
        self.topicDefinitionLabel.text = "B Bassoon"
        loadBassoon()
        self.sampler.startNote(71, withVelocity: 64, onChannel: 0)
        let coloredSquare = UIView()
        coloredSquare.backgroundColor = UIColor.purpleColor()
        coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
        self.view.addSubview(coloredSquare)
        UIView.animateWithDuration(1.0, animations: {
            coloredSquare.backgroundColor = UIColor.redColor()
            coloredSquare.frame = CGRect(x: 320-10, y: 350-0, width: 10, height: 50)
            }, completion: { finished in
                self.sampler.stopNote(71, onChannel: 0)
                coloredSquare.backgroundColor = UIColor.clearColor()
                coloredSquare.frame = CGRect(x: 10, y: 350, width: 10, height: 30)
                
        })
    }
    
    
    
    
    func initAudioEngine () {
        let fileURL = NSBundle.mainBundle().URLForResource("red", withExtension: "mp3")
        var error: NSError?
        let audioFile = AVAudioFile(forReading: fileURL, error: &error)
        //        let audioFile = AVAudioFile(forReading: fileURL, commonFormat: .PCMFormatFloat32, interleaved: false, error: &error)
        if let e = error {
            println(e.localizedDescription)
        }
        
        engine = AVAudioEngine()
        playerNode = AVAudioPlayerNode()
        engine.attachNode(playerNode)
        mixer = engine.mainMixerNode
        //engine.connect(playerNode, to: mixer, format: mixer.outputFormatForBus(0))
        
        engine.connect(playerNode, to: engine.mainMixerNode, format: audioFile.processingFormat)
        playerNode.scheduleFile(audioFile, atTime:nil, completionHandler:nil)
        
        // for the midi functionality
        initMIDI()
        
        if !engine.startAndReturnError(&error) {
            println("error couldn't start engine")
            if let e = error {
                println("error \(e.localizedDescription)")
            }
        }
        
    }
    
    func initMIDI() {
        sampler = AVAudioUnitSampler()
        engine.attachNode(sampler)
        engine.connect(sampler, to: engine.mainMixerNode, format: nil)
        soundbank = NSBundle.mainBundle().URLForResource("GeneralUser GS MuseScore v1.442", withExtension: "sf2")
    }

    func loadTuba() {
        var error:NSError?
        if !sampler.loadSoundBankInstrumentAtURL(soundbank, program: gmTuba,
            bankMSB: melodicBank, bankLSB: 0, error: &error) {
                println("could not load soundbank")
        }
        if let e = error {
            println("error \(e.localizedDescription)")
        }
        self.sampler.sendProgramChange(gmTuba, bankMSB: melodicBank, bankLSB: 0, onChannel: 0)
    }
    
    func loadMutedTrumpet() {
        var error:NSError?
        if !sampler.loadSoundBankInstrumentAtURL(soundbank, program: gmMutedTrumpet,
            bankMSB: melodicBank, bankLSB: 0, error: &error) {
                println("could not load soundbank")
        }
        if let e = error {
            println("error \(e.localizedDescription)")
        }
        self.sampler.sendProgramChange(gmMutedTrumpet, bankMSB: melodicBank, bankLSB: 0, onChannel: 0)
    }
    
    func loadViola() {
        var error:NSError?
        if !sampler.loadSoundBankInstrumentAtURL(soundbank, program: gmViola,
            bankMSB: melodicBank, bankLSB: 0, error: &error) {
                println("could not load soundbank")
        }
        if let e = error {
            println("error \(e.localizedDescription)")
        }
        self.sampler.sendProgramChange(gmViola, bankMSB: melodicBank, bankLSB: 0, onChannel: 0)
    }
    
    func loadViolin() {
        var error:NSError?
        if !sampler.loadSoundBankInstrumentAtURL(soundbank, program: gmViolin,
            bankMSB: melodicBank, bankLSB: 0, error: &error) {
                println("could not load soundbank")
        }
        if let e = error {
            println("error \(e.localizedDescription)")
        }
        self.sampler.sendProgramChange(gmViolin, bankMSB: melodicBank, bankLSB: 0, onChannel: 0)
    }
    
    func loadTubularBells() {
        var error:NSError?
        if !sampler.loadSoundBankInstrumentAtURL(soundbank, program: gmTubularBells,
            bankMSB: melodicBank, bankLSB: 0, error: &error) {
                println("could not load soundbank")
        }
        if let e = error {
            println("error \(e.localizedDescription)")
        }
        self.sampler.sendProgramChange(gmTubularBells, bankMSB: melodicBank, bankLSB: 0, onChannel: 0)
    }

    func loadTrumpet() {
        var error:NSError?
        if !sampler.loadSoundBankInstrumentAtURL(soundbank, program: gmTrumpet,
            bankMSB: melodicBank, bankLSB: 0, error: &error) {
                println("could not load soundbank")
        }
        if let e = error {
            println("error \(e.localizedDescription)")
        }
        self.sampler.sendProgramChange(gmTrumpet, bankMSB: melodicBank, bankLSB: 0, onChannel: 0)
    }

    func loadFlute() {
        var error:NSError?
        if !sampler.loadSoundBankInstrumentAtURL(soundbank, program: gmFlute,
            bankMSB: melodicBank, bankLSB: 0, error: &error) {
                println("could not load soundbank")
        }
        if let e = error {
            println("error \(e.localizedDescription)")
        }
        self.sampler.sendProgramChange(gmFlute, bankMSB: melodicBank, bankLSB: 0, onChannel: 0)
    }

    func loadCello() {
        var error:NSError?
        if !sampler.loadSoundBankInstrumentAtURL(soundbank, program: gmCello,
            bankMSB: melodicBank, bankLSB: 0, error: &error) {
                println("could not load soundbank")
        }
        if let e = error {
            println("error \(e.localizedDescription)")
        }
        self.sampler.sendProgramChange(gmCello, bankMSB: melodicBank, bankLSB: 0, onChannel: 0)
    }
    func loadPercussiveOrgan() {
        var error:NSError?
        if !sampler.loadSoundBankInstrumentAtURL(soundbank, program: gmPercussiveOrgan,
            bankMSB: melodicBank, bankLSB: 0, error: &error) {
                println("could not load soundbank")
        }
        if let e = error {
            println("error \(e.localizedDescription)")
        }
        self.sampler.sendProgramChange(gmPercussiveOrgan, bankMSB: melodicBank, bankLSB: 0, onChannel: 0)
    }
    func loadEnglishHorn() {
        var error:NSError?
        if !sampler.loadSoundBankInstrumentAtURL(soundbank, program: gmEnglishHorn,
            bankMSB: melodicBank, bankLSB: 0, error: &error) {
                println("could not load soundbank")
        }
        if let e = error {
            println("error \(e.localizedDescription)")
        }
        self.sampler.sendProgramChange(gmEnglishHorn, bankMSB: melodicBank, bankLSB: 0, onChannel: 0)
    }
    func loadBassoon() {
        var error:NSError?
        if !sampler.loadSoundBankInstrumentAtURL(soundbank, program: gmBassoon,
            bankMSB: melodicBank, bankLSB: 0, error: &error) {
                println("could not load soundbank")
        }
        if let e = error {
            println("error \(e.localizedDescription)")
        }
        self.sampler.sendProgramChange(gmBassoon, bankMSB: melodicBank, bankLSB: 0, onChannel: 0)
    }
    
    
    
    
    
    
    
    
    func hstart(sender: AnyObject) {
        self.sampler.startNote(69, withVelocity: 64, onChannel: 0)
        self.sampler.startNote(68, withVelocity: 64, onChannel: 0)
        self.sampler.startNote(67, withVelocity: 64, onChannel: 0)
        
    }
    
    func hstop(sender: AnyObject) {
        self.sampler.stopNote(69, onChannel: 0)
        self.sampler.stopNote(68, onChannel: 0)
        self.sampler.stopNote(67, onChannel: 0)
    }

    
    
    
}