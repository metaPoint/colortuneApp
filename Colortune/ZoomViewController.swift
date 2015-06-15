//
//  ZoomViewController.swift
//  Colortune
//
//  Created by Anna Torlen on 2/28/15.
//  Copyright (c) 2015 Anna Torlen. All rights reserved.
//


import Foundation
import UIKit
import AVFoundation
import CoreGraphics

//Midi Sound Files Created by Gene De Lisa on 8/13/14.
//  Copyright (c) 2014 Gene De Lisa. All rights reserved.



class ZoomViewController: UIViewController, UIScrollViewDelegate {
    
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
    let gmBassoon:UInt8 = 71 //magenta
    let gmMutedTrumpet:UInt8 = 60 //red
    let gmViolin:UInt8 = 41 //yellow //light green //green
    let gmCello:UInt8 = 42 //blue
    let gmPercussiveOrgan:UInt8 = 18 //indigo

    
    var sound:Sound = Sound()
    
    var gen = SoundGenerator()
   
//    @IBOutlet var playMIDIEvent: UIButton!
//    //end of midi
    
    var image : UIImage? = nil
    
    var imagePlay : UIImage = UIImage(named:"playbutton.png")!
    
    var randomNumber = CGFloat( arc4random_uniform(300))
    
    
    
    @IBOutlet var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //BEGININNING OF SOUND ////////
        
        
        initAudioEngine()
        //playerNodePlay()
        sound.toggleAVPlayer()
        
        
        //playAnimation.addTarget(self, action: "hstart:", forControlEvents: .TouchDown)
        //playAnimation.addTarget(self, action: "hstop:", forControlEvents: .TouchUpInside)
        //end of midi
        
        //var image : UIImage = UIImage(named:"icon.png")!
        //let image:UIImage = UIImage(named: "icon.png")!
        
        
        
        //gen.loadSF2Preset(11)
                
        
        
    } ////////end of view did load
    
    
    var GMDict:[String:UInt8] = [
        "Acoustic Grand Piano" : 0,
        "Bright Acoustic Piano" : 1,
        "Electric Grand Piano" : 2,
        "Honky-tonk Piano" : 3,
        "Electric Piano 1" : 4,
        "Electric Piano 2" : 5,
        "Harpsichord" : 6,
        "Clavi" : 7,
        "Celesta" : 8,
        "Glockenspiel" : 9,
        "Music Box" : 10,
        "Vibraphone" : 11,
        "Marimba" : 12,
        "Xylophone" : 13,
        "Tubular Bells" : 14,
        "Dulcimer" : 15,
        "Drawbar Organ" : 16,
        "Percussive Organ" : 17,
        "Rock Organ" : 18,
        "ChurchPipe" : 19,
        "Positive" : 20,
        "Accordion" : 21,
        "Harmonica" : 22,
        "Tango Accordion" : 23,
        "Classic Guitar" : 24,
        "Acoustic Guitar" : 25,
        "Jazz Guitar" : 26,
        "Clean Guitar" : 27,
        "Muted Guitar" : 28,
        "Overdriven Guitar" : 29,
        "Distortion Guitar" : 30,
        "Guitar harmonics" : 31,
        "JazzBass" : 32,
        "DeepBass" : 33,
        "PickBass" : 34,
        "FretLess" : 35,
        "SlapBass1" : 36,
        "SlapBass2" : 37,
        "SynthBass1" : 38,
        "SynthBass2" : 39,
        "Violin" : 40,
        "Viola" : 41,
        "Cello" : 42,
        "ContraBass" : 43,
        "TremoloStr" : 44,
        "Pizzicato" : 45,
        "Harp" : 46,
        "Timpani" : 47,
        "String Ensemble 1" : 48,
        "String Ensemble 2" : 49,
        "SynthStrings 1" : 50,
        "SynthStrings 2" : 51,
        "Choir" : 52,
        "DooVoice" : 53,
        "Voices" : 54,
        "OrchHit" : 55,
        "Trumpet" : 56,
        "Trombone" : 57,
        "Tuba" : 58,
        "MutedTrumpet" : 59,
        "FrenchHorn" : 60,
        "Brass" : 61,
        "SynBrass1" : 62,
        "SynBrass2" : 63,
        "SopranoSax" : 64,
        "AltoSax" : 65,
        "TenorSax" : 66,
        "BariSax" : 67,
        "Oboe" : 68,
        "EnglishHorn" : 69,
        "Bassoon" : 70,
        "Clarinet" : 71,
        "Piccolo" : 72,
        "Flute" : 73,
        "Recorder" : 74,
        "PanFlute" : 75,
        "Bottle" : 76,
        "Shakuhachi" : 77,
        "Whistle" : 78,
        "Ocarina" : 79,
        "SquareWave" : 80,
        "SawWave" : 81,
        "Calliope" : 82,
        "SynChiff" : 83,
        "Charang" : 84,
        "AirChorus" : 85,
        "fifths" : 86,
        "BassLead" : 87,
        "New Age" : 88,
        "WarmPad" : 89,
        "PolyPad" : 90,
        "GhostPad" : 91,
        "BowedGlas" : 92,
        "MetalPad" : 93,
        "HaloPad" : 94,
        "Sweep" : 95,
        "IceRain" : 96,
        "SoundTrack" : 97,
        "Crystal" : 98,
        "Atmosphere" : 99,
        "Brightness" : 100,
        "Goblin" : 101,
        "EchoDrop" : 102,
        "SciFi effect" : 103,
        "Sitar" : 104,
        "Banjo" : 105,
        "Shamisen" : 106,
        "Koto" : 107,
        "Kalimba" : 108,
        "Scotland" : 109,
        "Fiddle" : 110,
        "Shanai" : 111,
        "MetalBell" : 112,
        "Agogo" : 113,
        "SteelDrums" : 114,
        "Woodblock" : 115,
        "Taiko" : 116,
        "Tom" : 117,
        "SynthTom" : 118,
        "RevCymbal" : 119,
        "FretNoise" : 120,
        "NoiseChiff" : 121,
        "Seashore" : 122,
        "Birds" : 123,
        "Telephone" : 124,
        "Helicopter" : 125,
        "Stadium" : 126,
        "GunShot" : 127
    ]
    

    
    
    @IBAction func cancelZoom(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        gen.stop()
        
        
    }
    
    @IBAction func playAnimation(sender: AnyObject) {
        
        
        
        //gen.play()
        
        
        self.imageView.image = self.image!
        let image = self.imageView.image!
        var pixelpoint = CGPoint(x: randomNumber, y: randomNumber)
        var colorpoint = image.getPixelColorAtLocation(pixelpoint)
        self.view.backgroundColor = colorpoint
        
        var redval: CGFloat = 0
        var greenval: CGFloat = 0
        var blueval: CGFloat = 0
        var alphaval: CGFloat = 0
        var whiteval: CGFloat = 0
        colorpoint?.getRed(&redval, green: &greenval, blue: &blueval, alpha: &alphaval)
        println("Red is r: \(redval) g: \(greenval) b: \(blueval) a: \(alphaval)")
        println("\(colorpoint)")
        
        if (redval) >= 0.5 {
            
            
            gen.loadSF2Preset(33)
            gen.createMusicSequence(60, y: 64)
            gen.play()
            redanimation()
            println("33") //deep bass
            

        } else if (greenval) >= 0.5 {
            
            gen.loadSF2Preset(40)
            //gen.createMusicSequence(60, y: 64)
            gen.play()
            greenanimation()
            println("40") //violin
            

    } else if (blueval) >= 0.5 {
            
            gen.loadSF2Preset(42)
            //gen.createMusicSequence(60, y: 64)
            gen.play()
            blueanimation()
            println("42") //cello
            
            
        } else if (redval + blueval >= 1.0){
            
            gen.loadSF2Preset(56)
            //gen.createMusicSequence(60, y: 64)
            gen.play()
            redblueanimation()
            println("56") //trumpet


        } else {
            
            gen.loadSF2Preset(17)
            //gen.createMusicSequence(60, y: 64)
            gen.play()
            redblueanimation()
            println("17") // percussive organ
            
        }
        
        if (redval) >= 0.9 {
            
            
            gen.loadSF2Preset(33)
            //gen.createMusicSequence(60, y: 64)
            gen.play()
            redanimation()
            println("33") //deep bass
            
            
        }
        
        
        

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

    
    func redanimation() {
        
        
        
        
        for loopNumber in 0...10 {
            
            
            let coloredSquare1 = UIView()
            let coloredSquare2 = UIView()
            let coloredSquare3 = UIView()
            
            
            // set background color to blue
            coloredSquare1.backgroundColor = UIColor.redColor()
            coloredSquare2.backgroundColor = UIColor.blueColor()
            coloredSquare3.backgroundColor = UIColor.greenColor()
            
            // set frame (position and size) of the square
            // iOS coordinate system starts at the top left of the screen
            // so this square will be at top left of screen, 50x50pt
            // CG in CGRect stands for Core Graphics
            coloredSquare1.frame = CGRect(x: 0, y: 10, width: 10, height: 20)
            coloredSquare2.frame = CGRect(x: 0, y: 10, width: 10, height: 20)
            coloredSquare3.frame = CGRect(x: 0, y: 10, width: 10, height: 20)
            
            // finally, add the square to the screen
            self.view.addSubview(coloredSquare1)
            self.view.addSubview(coloredSquare2)
            self.view.addSubview(coloredSquare3)
            
            let options = UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat | UIViewAnimationOptions.CurveEaseInOut
            let duration = 1.0
            let delay = 0.0
            let damping = 0.5 // set damping ration
            let velocity = 1.0 // set initial velocity
            let fullRotation = CGFloat(M_PI * 2)
            
            
            UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
                coloredSquare1.backgroundColor = UIColor.redColor()
                coloredSquare2.backgroundColor = UIColor.greenColor()
                coloredSquare3.backgroundColor = UIColor.blueColor()
                
                // for the x-position I entered 320-50 (width of screen - width of the square)
                // if you want, you could just enter 270
                // but I prefer to enter the math as a reminder of what's happenings
                coloredSquare1.frame = CGRect(x: 320-50, y: 20, width: 10, height: 50)
                coloredSquare2.frame = CGRect(x: 320-50, y: 120, width: 10, height: 50)
                coloredSquare3.frame = CGRect(x: 320-50, y: 220, width: 10, height: 50)
                
                }, completion: nil)
            
            
            
        } //end of RGBColorBlocksloop

        ///Begin Animation
        ///////Animation
        for i in 0...5 {
            
            // create a square
            let square = UIView()
            square.frame = CGRect(x: 55, y: 600, width: 20, height: 20)
            square.backgroundColor = UIColor.blackColor()
            self.view.addSubview(square)
            
            // randomly create a value between 0.0 and 150.0
            let randomYOffset = CGFloat( arc4random_uniform(150))
            
            // for every y-value on the bezier curve
            // add our random y offset so that each individual animation
            // will appear at a different y-position
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 16,y: 16 + randomYOffset))
            path.addCurveToPoint(CGPoint(x: 301, y: 239 + randomYOffset), controlPoint1: CGPoint(x: 136, y: 373 + randomYOffset), controlPoint2: CGPoint(x: 178, y: 110 + randomYOffset))
            
            // create the animation
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.CGPath
            anim.rotationMode = kCAAnimationRotateAuto
            anim.repeatCount = Float.infinity
            //anim.duration = 5.0
            anim.duration = Double(arc4random_uniform(40)+30) / 10
            anim.timeOffset = Double(arc4random_uniform(290))
            
            // add the animation
            square.layer.addAnimation(anim, forKey: "animate position along path")
            
        }
        
        ///draw circle
        let ovalStartAngle = CGFloat(90.01 * M_PI/180)
        let ovalEndAngle = CGFloat(90 * M_PI/180)
        let ovalRect = CGRectMake(100, 300, 75, 75) //location //y was 200, 300 was 400
        
        // create the bezier path
        let ovalPath = UIBezierPath()
        
        ovalPath.addArcWithCenter(CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)),
            radius: CGRectGetWidth(ovalRect) / 2,
            startAngle: ovalStartAngle,
            endAngle: ovalEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        let progressLine = CAShapeLayer()
        progressLine.path = ovalPath.CGPath
        progressLine.strokeColor = UIColor.blackColor().CGColor
        progressLine.fillColor = UIColor.blueColor().CGColor
        progressLine.fillColor = UIColor.clearColor().CGColor
        progressLine.lineWidth = 8.0 //10.0
        progressLine.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(progressLine)
        
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = 3.0
        animateStrokeEnd.fromValue = 0.0
        animateStrokeEnd.toValue = 1.0
        
        
        // add the animation
        progressLine.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
        
        
        
        //////////////// ///draw circle 2
        let halfMoonStartAngle = CGFloat(10.01 * M_PI/180)
        let halfMoonEndAngle = CGFloat(10 * M_PI/180)
        let halfMoonRect = CGRectMake(80, 260, 300, 300) //location
        
        // create the bezier path
        let halfMoonPath = UIBezierPath()
        
        halfMoonPath.addArcWithCenter(CGPointMake(CGRectGetMidX(halfMoonRect), CGRectGetMidY(halfMoonRect)),
            radius: CGRectGetWidth(halfMoonRect) / 2,
            startAngle: halfMoonStartAngle,
            endAngle: halfMoonEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        let halfMoon = CAShapeLayer()
        halfMoon.path = halfMoonPath.CGPath
        halfMoon.strokeColor = UIColor.blackColor().CGColor
        //halfMoon.fillColor = UIColor.redColor().CGColor
        halfMoon.fillColor = UIColor.clearColor().CGColor
        halfMoon.lineWidth = 4.0 //10.0
        halfMoon.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(halfMoon)
        
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEndTwo = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndTwo.duration = 2.0
        animateStrokeEndTwo.fromValue = 0.0
        animateStrokeEndTwo.toValue = 1.0
        
        
        // add the animation
        halfMoon.addAnimation(animateStrokeEndTwo, forKey: "animate stroke end animation")
        
        /////////yellow circle
        let yellowShapeStartAngle = CGFloat(10.01 * M_PI/180)
        let yellowShapeEndAngle = CGFloat(10 * M_PI/180)
        let yellowShapeRect = CGRectMake(280, 460, 50, 50) //location 20, 20
        
        let yellowShapePath = UIBezierPath()
        
        
        yellowShapePath.addArcWithCenter(CGPointMake(CGRectGetMidX(yellowShapeRect), CGRectGetMidY(yellowShapeRect)),
            radius: CGRectGetWidth(yellowShapeRect) / 2,
            startAngle: yellowShapeStartAngle,
            endAngle: yellowShapeEndAngle, clockwise: true)
        
        let yellowShape = CAShapeLayer()
        yellowShape.path = yellowShapePath.CGPath
        yellowShape.strokeColor = UIColor.blackColor().CGColor
        yellowShape.fillColor = UIColor.redColor().CGColor
        yellowShape.lineWidth = 4.0 //3.0
        yellowShape.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(yellowShape)
        
        let animateStrokeEndThree = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndThree.duration = 3.0
        animateStrokeEndThree.fromValue = 0.0
        animateStrokeEndThree.toValue = 1.0
        
        yellowShape.addAnimation(animateStrokeEndTwo, forKey: "animate stroke end animation")
        
        /////////////
        let yellowShapeTwoStartAngle = CGFloat(10.01 * M_PI/180)
        let yellowShapeTwoEndAngle = CGFloat(10 * M_PI/180)
        let yellowShapeTwoRect = CGRectMake(220, 240, 30, 30) //location 20, 20
        
        let yellowShapeTwoPath = UIBezierPath()
        
        
        yellowShapeTwoPath.addArcWithCenter(CGPointMake(CGRectGetMidX(yellowShapeTwoRect), CGRectGetMidY(yellowShapeTwoRect)),
            radius: CGRectGetWidth(yellowShapeTwoRect) / 2,
            startAngle: yellowShapeTwoStartAngle,
            endAngle: yellowShapeTwoEndAngle, clockwise: true)
        
        let yellowShapeTwo = CAShapeLayer()
        yellowShapeTwo.path = yellowShapeTwoPath.CGPath
        yellowShapeTwo.strokeColor = UIColor.blackColor().CGColor
        yellowShapeTwo.fillColor = UIColor.redColor().CGColor
        yellowShapeTwo.lineWidth = 3.0
        yellowShapeTwo.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(yellowShapeTwo)
        
        let animateStrokeEndFour = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndFour.duration = 3.0
        animateStrokeEndFour.fromValue = 0.0
        animateStrokeEndFour.toValue = 1.0
        
        yellowShapeTwo.addAnimation(animateStrokeEndFour, forKey: "animate stroke end animation")
        
        ///////
        /////////////
        let yellowShapeThreeStartAngle = CGFloat(10.01 * M_PI/180)
        let yellowShapeThreeEndAngle = CGFloat(10 * M_PI/180)
        let yellowShapeThreeRect = CGRectMake(220, 600, 20, 20) //location
        
        let yellowShapeThreePath = UIBezierPath()
        
        
        yellowShapeThreePath.addArcWithCenter(CGPointMake(CGRectGetMidX(yellowShapeThreeRect), CGRectGetMidY(yellowShapeThreeRect)),
            radius: CGRectGetWidth(yellowShapeThreeRect) / 2,
            startAngle: yellowShapeThreeStartAngle,
            endAngle: yellowShapeThreeEndAngle, clockwise: true)
        
        let yellowShapeThree = CAShapeLayer()
        yellowShapeThree.path = yellowShapeThreePath.CGPath
        yellowShapeThree.strokeColor = UIColor.blackColor().CGColor
        yellowShapeThree.fillColor = UIColor.redColor().CGColor
        yellowShapeThree.lineWidth = 3.0
        yellowShapeThree.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(yellowShapeThree)
        
        let animateStrokeEndFive = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndFive.duration = 3.0
        animateStrokeEndFive.fromValue = 0.0
        animateStrokeEndFive.toValue = 1.0
        
        yellowShapeThree.addAnimation(animateStrokeEndFive, forKey: "animate stroke end animation")
        
        
        /////greencircles
        /////////////
        let greenShapeStartAngle = CGFloat(10.01 * M_PI/180)
        let greenShapeEndAngle = CGFloat(10 * M_PI/180)
        let greenShapeRect = CGRectMake(20, 300, 20, 20) //location
        
        let greenShapePath = UIBezierPath()
        
        
        greenShapePath.addArcWithCenter(CGPointMake(CGRectGetMidX(greenShapeRect), CGRectGetMidY(greenShapeRect)),
            radius: CGRectGetWidth(greenShapeRect) / 2,
            startAngle: greenShapeStartAngle,
            endAngle: greenShapeEndAngle, clockwise: true)
        
        let greenShape = CAShapeLayer()
        greenShape.path = greenShapePath.CGPath
        greenShape.strokeColor = UIColor.blackColor().CGColor
        greenShape.fillColor = UIColor.redColor().CGColor
        greenShape.lineWidth = 3.0
        greenShape.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(greenShape)
        
        let animateStrokeEndSix = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndSix.duration = 3.0
        animateStrokeEndSix.fromValue = 0.0
        animateStrokeEndSix.toValue = 1.0
        
        greenShape.addAnimation(animateStrokeEndSix, forKey: "animate stroke end animation")
        
        ///     /////greencircles
        /////////////
        let greenShapeTwoStartAngle = CGFloat(10.01 * M_PI/180)
        let greenShapeTwoEndAngle = CGFloat(10 * M_PI/180)
        let greenShapeTwoRect = CGRectMake(120, 300, 20, 20) //location
        
        let greenShapeTwoPath = UIBezierPath()
        
        
        greenShapeTwoPath.addArcWithCenter(CGPointMake(CGRectGetMidX(greenShapeTwoRect), CGRectGetMidY(greenShapeTwoRect)),
            radius: CGRectGetWidth(greenShapeTwoRect) / 2,
            startAngle: greenShapeTwoStartAngle,
            endAngle: greenShapeTwoEndAngle, clockwise: true)
        
        let greenShapeTwo = CAShapeLayer()
        greenShapeTwo.path = greenShapeTwoPath.CGPath
        greenShapeTwo.strokeColor = UIColor.blackColor().CGColor
        greenShapeTwo.fillColor = UIColor.redColor().CGColor
        greenShapeTwo.lineWidth = 3.0
        greenShapeTwo.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(greenShapeTwo)
        
        let animateStrokeEndSeven = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndSeven.duration = 3.0
        animateStrokeEndSeven.fromValue = 0.0
        animateStrokeEndSeven.toValue = 1.0
        
        greenShapeTwo.addAnimation(animateStrokeEndSeven, forKey: "animate stroke end animation")
        
        ///////gray arc
        
        
        let grayArcPath = UIBezierPath()
        
        let grayArc = CAShapeLayer()
        let grow = CGRect(x: 50, y: 50, width: 100, height: 100)
        grayArc.bounds = grow
        grayArc.position = view.center
        grayArc.cornerRadius = grow.width / 2
        self.view.layer.addSublayer(grayArc)
        grayArc.path = UIBezierPath(ovalInRect: grayArc.bounds).CGPath
        
        grayArc.strokeColor = UIColor.lightGrayColor().CGColor
        grayArc.fillColor = UIColor.clearColor().CGColor
        grayArc.lineWidth = 7.0
        grayArc.lineCap = kCALineCapRound
        
        grayArc.strokeStart = 0
        grayArc.strokeEnd = 0.5
        
        // add the curve to the screen
        
        
        // 3
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 0.7
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1
        
        // 4
        let group = CAAnimationGroup()
        group.animations = [start, end]
        group.duration = 1.5
        group.autoreverses = true
        group.repeatCount = HUGE // repeat forver
        grayArc.addAnimation(group, forKey: nil)
        
        //////grayArc2
        
        
        let grayArc2Path = UIBezierPath()
        
        
        let grayArc2 = CAShapeLayer()
        let grow2 = CGRect(x: 100, y: 100, width: 200, height: 200)
        grayArc2.bounds = grow2
        grayArc2.position = view.center
        grayArc2.cornerRadius = grow2.width / 2
        self.view.layer.addSublayer(grayArc2)
        grayArc2.path = UIBezierPath(ovalInRect: grayArc2.bounds).CGPath
        
        grayArc2.strokeColor = UIColor.lightGrayColor().CGColor
        grayArc2.fillColor = UIColor.clearColor().CGColor
        grayArc2.lineWidth = 7.0
        grayArc2.lineCap = kCALineCapRound
        
        grayArc2.strokeStart = 0
        grayArc2.strokeEnd = 0.5
        
        // add the curve to the screen
        
        
        // 3
        let start2 = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 0.7
        let end2 = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1
        
        // 4
        let group2 = CAAnimationGroup()
        group2.animations = [start, end]
        group2.duration = 1.5
        group2.autoreverses = true
        group2.repeatCount = HUGE // repeat forver
        grayArc2.addAnimation(group, forKey: nil)
        
        ////gray Lines
        
        let grayLine = CAShapeLayer()
        
        
        
        
        grayLine.strokeColor = UIColor.darkGrayColor().CGColor
        grayLine.fillColor = UIColor.clearColor().CGColor
        grayLine.lineWidth = 7.0
        grayLine.lineCap = kCALineCapRound
        
        
        
        // add the curve to the screen
        self.view.layer.addSublayer(grayLine)
        
        let animateStrokeEndgrayLine = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndgrayLine.duration = 3.0
        animateStrokeEndgrayLine.fromValue = 0.0
        animateStrokeEndgrayLine.toValue = 1.0
        
        grayLine.addAnimation(animateStrokeEndgrayLine, forKey: "animate stroke end animation")
        ///   ///// /////black Line
        
        let fullRotation = CGFloat(M_PI * 2)
        
        
        
        let blacksquare = UIView()
        blacksquare.backgroundColor = UIColor.blackColor()
        blacksquare.frame = CGRect(x: 200, y: 200, width: 6, height: 500)
        self.view.addSubview(blacksquare)
        
        let options = UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat | UIViewAnimationOptions.CurveEaseInOut
        let duration = 1.0
        let delay = 0.0
        let damping = 0.5 // set damping ration
        let velocity = 1.0 // set initial velocity
        //let fullRotation = CGFloat(M_PI * 2)
        
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
            blacksquare.backgroundColor = UIColor.blackColor()
            blacksquare.frame = CGRect(x: 420-50, y: 20, width: 10, height: 50)
            
            }, completion: nil)
        
        
        ////colorLines
        
        
        let colorLines = UIView()
        colorLines.backgroundColor = UIColor.lightGrayColor()
        colorLines.frame = CGRect(x: 20, y: 200, width: 20, height: 20)
        self.view.addSubview(colorLines)
        
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
            colorLines.backgroundColor = UIColor.lightGrayColor()
            colorLines.frame = CGRect(x: 200, y: 50, width: 200, height: 10)
            
            }, completion: nil)
        
        
        
        
        let blackCircleStartAngle = CGFloat(90.01 * M_PI/180)
        let blackCircleEndAngle = CGFloat(90 * M_PI/180)
        let blackCircleRect = CGRectMake(50, 550, 30, 30) //location
        
        // create the bezier path
        let blackCirclePath = UIBezierPath()
        
        blackCirclePath.addArcWithCenter(CGPointMake(CGRectGetMidX(blackCircleRect), CGRectGetMidY(blackCircleRect)),
            radius: CGRectGetWidth(blackCircleRect) / 2,
            startAngle: blackCircleStartAngle,
            endAngle: blackCircleEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        let blackCircle = CAShapeLayer()
        blackCircle.path = blackCirclePath.CGPath
        blackCircle.strokeColor = UIColor.blackColor().CGColor
        blackCircle.fillColor = UIColor.blackColor().CGColor
        //blackCircle.fillColor = UIColor.clearColor().CGColor
        blackCircle.lineWidth = 1.0
        blackCircle.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(blackCircle)
        
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEndblackCircle = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndblackCircle.duration = 3.0
        animateStrokeEndblackCircle.fromValue = 0.0
        animateStrokeEndblackCircle.toValue = 1.0
        
        
        // add the animation
        blackCircle.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
        
        
        let markerLines = UIView()
        markerLines.backgroundColor = UIColor.orangeColor()
        markerLines.frame = CGRect(x: 200, y: 10, width: 15, height: 300)
        markerLines.transform = CGAffineTransformMakeRotation(2/3 * fullRotation)
        self.view.addSubview(markerLines)
        UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
            markerLines.backgroundColor = UIColor.redColor()
            markerLines.frame = CGRect(x: 200, y: 10, width: 15, height: 10)
            
            }, completion: nil)
        

        
        
    }
    
    func greenanimation() {
        
        
        
        for loopNumber in 0...10 {
            
            
            let coloredSquare1 = UIView()
            let coloredSquare2 = UIView()
            let coloredSquare3 = UIView()
            
            
            // set background color to blue
            coloredSquare1.backgroundColor = UIColor.redColor()
            coloredSquare2.backgroundColor = UIColor.blueColor()
            coloredSquare3.backgroundColor = UIColor.greenColor()
            
            // set frame (position and size) of the square
            // iOS coordinate system starts at the top left of the screen
            // so this square will be at top left of screen, 50x50pt
            // CG in CGRect stands for Core Graphics
            coloredSquare1.frame = CGRect(x: 0, y: 10, width: 10, height: 20)
            coloredSquare2.frame = CGRect(x: 0, y: 10, width: 10, height: 20)
            coloredSquare3.frame = CGRect(x: 0, y: 10, width: 10, height: 20)
            
            // finally, add the square to the screen
            self.view.addSubview(coloredSquare1)
            self.view.addSubview(coloredSquare2)
            self.view.addSubview(coloredSquare3)
            
            let options = UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat | UIViewAnimationOptions.CurveEaseInOut
            let duration = 1.0
            let delay = 0.0
            let damping = 0.5 // set damping ration
            let velocity = 1.0 // set initial velocity
            let fullRotation = CGFloat(M_PI * 2)
            
            
            UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
                coloredSquare1.backgroundColor = UIColor.redColor()
                coloredSquare2.backgroundColor = UIColor.greenColor()
                coloredSquare3.backgroundColor = UIColor.blueColor()
                
                // for the x-position I entered 320-50 (width of screen - width of the square)
                // if you want, you could just enter 270
                // but I prefer to enter the math as a reminder of what's happenings
                coloredSquare1.frame = CGRect(x: 320-50, y: 20, width: 10, height: 50)
                coloredSquare2.frame = CGRect(x: 320-50, y: 120, width: 10, height: 50)
                coloredSquare3.frame = CGRect(x: 320-50, y: 220, width: 10, height: 50)
                
                }, completion: nil)
            
            
        } //end of RGBColorBlocksloop
        
        ///Begin Animation
        ///////Animation
        for i in 0...5 {
            
            // create a square
            let square = UIView()
            square.frame = CGRect(x: 55, y: 600, width: 20, height: 20)
            square.backgroundColor = UIColor.blackColor()
            self.view.addSubview(square)
            
            // randomly create a value between 0.0 and 150.0
            let randomYOffset = CGFloat( arc4random_uniform(150))
            
            // for every y-value on the bezier curve
            // add our random y offset so that each individual animation
            // will appear at a different y-position
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 16,y: 16 + randomYOffset))
            path.addCurveToPoint(CGPoint(x: 301, y: 239 + randomYOffset), controlPoint1: CGPoint(x: 136, y: 373 + randomYOffset), controlPoint2: CGPoint(x: 178, y: 110 + randomYOffset))
            
            // create the animation
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.CGPath
            anim.rotationMode = kCAAnimationRotateAuto
            anim.repeatCount = Float.infinity
            //anim.duration = 5.0
            anim.duration = Double(arc4random_uniform(40)+30) / 10
            anim.timeOffset = Double(arc4random_uniform(290))
            
            // add the animation
            square.layer.addAnimation(anim, forKey: "animate position along path")
            
        }
        
        ///draw circle
        let ovalStartAngle = CGFloat(90.01 * M_PI/180)
        let ovalEndAngle = CGFloat(90 * M_PI/180)
        let ovalRect = CGRectMake(100, 400, 75, 75) //location //y was 200
        
        // create the bezier path
        let ovalPath = UIBezierPath()
        
        ovalPath.addArcWithCenter(CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)),
            radius: CGRectGetWidth(ovalRect) / 2,
            startAngle: ovalStartAngle,
            endAngle: ovalEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        let progressLine = CAShapeLayer()
        progressLine.path = ovalPath.CGPath
        progressLine.strokeColor = UIColor.blackColor().CGColor
        progressLine.fillColor = UIColor.greenColor().CGColor
        progressLine.fillColor = UIColor.clearColor().CGColor
        progressLine.lineWidth = 10.0
        progressLine.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(progressLine)
        
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = 3.0
        animateStrokeEnd.fromValue = 0.0
        animateStrokeEnd.toValue = 1.0
        
        
        // add the animation
        progressLine.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
        
        
        
        //////////////// ///draw circle 2
        let halfMoonStartAngle = CGFloat(10.01 * M_PI/180)
        let halfMoonEndAngle = CGFloat(10 * M_PI/180)
        let halfMoonRect = CGRectMake(80, 260, 300, 300) //location
        
        // create the bezier path
        let halfMoonPath = UIBezierPath()
        
        halfMoonPath.addArcWithCenter(CGPointMake(CGRectGetMidX(halfMoonRect), CGRectGetMidY(halfMoonRect)),
            radius: CGRectGetWidth(halfMoonRect) / 2,
            startAngle: halfMoonStartAngle,
            endAngle: halfMoonEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        let halfMoon = CAShapeLayer()
        halfMoon.path = halfMoonPath.CGPath
        halfMoon.strokeColor = UIColor.blackColor().CGColor
        halfMoon.fillColor = UIColor.greenColor().CGColor
        //halfMoon.fillColor = UIColor.clearColor().CGColor
        halfMoon.lineWidth = 10.0
        halfMoon.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(halfMoon)
        
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEndTwo = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndTwo.duration = 3.0
        animateStrokeEndTwo.fromValue = 0.0
        animateStrokeEndTwo.toValue = 1.0
        
        
        // add the animation
        halfMoon.addAnimation(animateStrokeEndTwo, forKey: "animate stroke end animation")
        
        /////////yellow circle
        let yellowShapeStartAngle = CGFloat(10.01 * M_PI/180)
        let yellowShapeEndAngle = CGFloat(10 * M_PI/180)
        let yellowShapeRect = CGRectMake(280, 460, 20, 20) //location
        
        let yellowShapePath = UIBezierPath()
        
        
        yellowShapePath.addArcWithCenter(CGPointMake(CGRectGetMidX(yellowShapeRect), CGRectGetMidY(yellowShapeRect)),
            radius: CGRectGetWidth(yellowShapeRect) / 2,
            startAngle: yellowShapeStartAngle,
            endAngle: yellowShapeEndAngle, clockwise: true)
        
        let yellowShape = CAShapeLayer()
        yellowShape.path = yellowShapePath.CGPath
        yellowShape.strokeColor = UIColor.blackColor().CGColor
        yellowShape.fillColor = UIColor.greenColor().CGColor
        yellowShape.lineWidth = 3.0
        yellowShape.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(yellowShape)
        
        let animateStrokeEndThree = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndThree.duration = 3.0
        animateStrokeEndThree.fromValue = 0.0
        animateStrokeEndThree.toValue = 1.0
        
        yellowShape.addAnimation(animateStrokeEndTwo, forKey: "animate stroke end animation")
        
        /////////////
        let yellowShapeTwoStartAngle = CGFloat(10.01 * M_PI/180)
        let yellowShapeTwoEndAngle = CGFloat(10 * M_PI/180)
        let yellowShapeTwoRect = CGRectMake(220, 240, 20, 20) //location
        
        let yellowShapeTwoPath = UIBezierPath()
        
        
        yellowShapeTwoPath.addArcWithCenter(CGPointMake(CGRectGetMidX(yellowShapeTwoRect), CGRectGetMidY(yellowShapeTwoRect)),
            radius: CGRectGetWidth(yellowShapeTwoRect) / 2,
            startAngle: yellowShapeTwoStartAngle,
            endAngle: yellowShapeTwoEndAngle, clockwise: true)
        
        let yellowShapeTwo = CAShapeLayer()
        yellowShapeTwo.path = yellowShapeTwoPath.CGPath
        yellowShapeTwo.strokeColor = UIColor.blackColor().CGColor
        yellowShapeTwo.fillColor = UIColor.greenColor().CGColor
        yellowShapeTwo.lineWidth = 3.0
        yellowShapeTwo.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(yellowShapeTwo)
        
        let animateStrokeEndFour = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndFour.duration = 3.0
        animateStrokeEndFour.fromValue = 0.0
        animateStrokeEndFour.toValue = 1.0
        
        yellowShapeTwo.addAnimation(animateStrokeEndFour, forKey: "animate stroke end animation")
        
        ///////
        /////////////
        let yellowShapeThreeStartAngle = CGFloat(10.01 * M_PI/180)
        let yellowShapeThreeEndAngle = CGFloat(10 * M_PI/180)
        let yellowShapeThreeRect = CGRectMake(220, 600, 20, 20) //location
        
        let yellowShapeThreePath = UIBezierPath()
        
        
        yellowShapeThreePath.addArcWithCenter(CGPointMake(CGRectGetMidX(yellowShapeThreeRect), CGRectGetMidY(yellowShapeThreeRect)),
            radius: CGRectGetWidth(yellowShapeThreeRect) / 2,
            startAngle: yellowShapeThreeStartAngle,
            endAngle: yellowShapeThreeEndAngle, clockwise: true)
        
        let yellowShapeThree = CAShapeLayer()
        yellowShapeThree.path = yellowShapeThreePath.CGPath
        yellowShapeThree.strokeColor = UIColor.blackColor().CGColor
        yellowShapeThree.fillColor = UIColor.greenColor().CGColor
        yellowShapeThree.lineWidth = 3.0
        yellowShapeThree.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(yellowShapeThree)
        
        let animateStrokeEndFive = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndFive.duration = 3.0
        animateStrokeEndFive.fromValue = 0.0
        animateStrokeEndFive.toValue = 1.0
        
        yellowShapeThree.addAnimation(animateStrokeEndFive, forKey: "animate stroke end animation")
        
        
        /////greencircles
        /////////////
        let greenShapeStartAngle = CGFloat(10.01 * M_PI/180)
        let greenShapeEndAngle = CGFloat(10 * M_PI/180)
        let greenShapeRect = CGRectMake(20, 300, 20, 20) //location
        
        let greenShapePath = UIBezierPath()
        
        
        greenShapePath.addArcWithCenter(CGPointMake(CGRectGetMidX(greenShapeRect), CGRectGetMidY(greenShapeRect)),
            radius: CGRectGetWidth(greenShapeRect) / 2,
            startAngle: greenShapeStartAngle,
            endAngle: greenShapeEndAngle, clockwise: true)
        
        let greenShape = CAShapeLayer()
        greenShape.path = greenShapePath.CGPath
        greenShape.strokeColor = UIColor.blackColor().CGColor
        greenShape.fillColor = UIColor.greenColor().CGColor
        greenShape.lineWidth = 3.0
        greenShape.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(greenShape)
        
        let animateStrokeEndSix = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndSix.duration = 3.0
        animateStrokeEndSix.fromValue = 0.0
        animateStrokeEndSix.toValue = 1.0
        
        greenShape.addAnimation(animateStrokeEndSix, forKey: "animate stroke end animation")
        
        ///     /////greencircles
        /////////////
        let greenShapeTwoStartAngle = CGFloat(10.01 * M_PI/180)
        let greenShapeTwoEndAngle = CGFloat(10 * M_PI/180)
        let greenShapeTwoRect = CGRectMake(120, 300, 20, 20) //location
        
        let greenShapeTwoPath = UIBezierPath()
        
        
        greenShapeTwoPath.addArcWithCenter(CGPointMake(CGRectGetMidX(greenShapeTwoRect), CGRectGetMidY(greenShapeTwoRect)),
            radius: CGRectGetWidth(greenShapeTwoRect) / 2,
            startAngle: greenShapeTwoStartAngle,
            endAngle: greenShapeTwoEndAngle, clockwise: true)
        
        let greenShapeTwo = CAShapeLayer()
        greenShapeTwo.path = greenShapeTwoPath.CGPath
        greenShapeTwo.strokeColor = UIColor.blackColor().CGColor
        greenShapeTwo.fillColor = UIColor.greenColor().CGColor
        greenShapeTwo.lineWidth = 3.0
        greenShapeTwo.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(greenShapeTwo)
        
        let animateStrokeEndSeven = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndSeven.duration = 3.0
        animateStrokeEndSeven.fromValue = 0.0
        animateStrokeEndSeven.toValue = 1.0
        
        greenShapeTwo.addAnimation(animateStrokeEndSeven, forKey: "animate stroke end animation")
        
        ///////gray arc
        
        
        let grayArcPath = UIBezierPath()
        
        let grayArc = CAShapeLayer()
        let grow = CGRect(x: 50, y: 50, width: 100, height: 100)
        grayArc.bounds = grow
        grayArc.position = view.center
        grayArc.cornerRadius = grow.width / 2
        self.view.layer.addSublayer(grayArc)
        grayArc.path = UIBezierPath(ovalInRect: grayArc.bounds).CGPath
        
        grayArc.strokeColor = UIColor.lightGrayColor().CGColor
        grayArc.fillColor = UIColor.clearColor().CGColor
        grayArc.lineWidth = 7.0
        grayArc.lineCap = kCALineCapRound
        
        grayArc.strokeStart = 0
        grayArc.strokeEnd = 0.5
        
        // add the curve to the screen
        
        
        // 3
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 0.7
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1
        
        // 4
        let group = CAAnimationGroup()
        group.animations = [start, end]
        group.duration = 1.5
        group.autoreverses = true
        group.repeatCount = HUGE // repeat forver
        grayArc.addAnimation(group, forKey: nil)
        
        //////grayArc2
        
        
        let grayArc2Path = UIBezierPath()
        
        
        let grayArc2 = CAShapeLayer()
        let grow2 = CGRect(x: 100, y: 100, width: 200, height: 200)
        grayArc2.bounds = grow2
        grayArc2.position = view.center
        grayArc2.cornerRadius = grow2.width / 2
        self.view.layer.addSublayer(grayArc2)
        grayArc2.path = UIBezierPath(ovalInRect: grayArc2.bounds).CGPath
        
        grayArc2.strokeColor = UIColor.lightGrayColor().CGColor
        grayArc2.fillColor = UIColor.clearColor().CGColor
        grayArc2.lineWidth = 7.0
        grayArc2.lineCap = kCALineCapRound
        
        grayArc2.strokeStart = 0
        grayArc2.strokeEnd = 0.5
        
        // add the curve to the screen
        
        
        // 3
        let start2 = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 0.7
        let end2 = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1
        
        // 4
        let group2 = CAAnimationGroup()
        group2.animations = [start, end]
        group2.duration = 1.5
        group2.autoreverses = true
        group2.repeatCount = HUGE // repeat forver
        grayArc2.addAnimation(group, forKey: nil)
        
        ////gray Lines
        
        let grayLine = CAShapeLayer()
        
        
        
        
        grayLine.strokeColor = UIColor.darkGrayColor().CGColor
        grayLine.fillColor = UIColor.clearColor().CGColor
        grayLine.lineWidth = 7.0
        grayLine.lineCap = kCALineCapRound
        
        
        
        // add the curve to the screen
        self.view.layer.addSublayer(grayLine)
        
        let animateStrokeEndgrayLine = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndgrayLine.duration = 3.0
        animateStrokeEndgrayLine.fromValue = 0.0
        animateStrokeEndgrayLine.toValue = 1.0
        
        grayLine.addAnimation(animateStrokeEndgrayLine, forKey: "animate stroke end animation")
        ///   ///// /////black Line
        
        let fullRotation = CGFloat(M_PI * 2)
        
        
        
        let blacksquare = UIView()
        blacksquare.backgroundColor = UIColor.blackColor()
        blacksquare.frame = CGRect(x: 200, y: 200, width: 6, height: 500)
        self.view.addSubview(blacksquare)
        
        let options = UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat | UIViewAnimationOptions.CurveEaseInOut
        let duration = 1.0
        let delay = 0.0
        let damping = 0.5 // set damping ration
        let velocity = 1.0 // set initial velocity
        //let fullRotation = CGFloat(M_PI * 2)
        
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
            blacksquare.backgroundColor = UIColor.blackColor()
            blacksquare.frame = CGRect(x: 420-50, y: 20, width: 10, height: 50)
            
            }, completion: nil)
        
        
        ////colorLines
        
        
        let colorLines = UIView()
        colorLines.backgroundColor = UIColor.lightGrayColor()
        colorLines.frame = CGRect(x: 20, y: 200, width: 20, height: 20)
        self.view.addSubview(colorLines)
        
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
            colorLines.backgroundColor = UIColor.lightGrayColor()
            colorLines.frame = CGRect(x: 200, y: 50, width: 200, height: 10)
            
            }, completion: nil)
        
        
        
        
        let blackCircleStartAngle = CGFloat(90.01 * M_PI/180)
        let blackCircleEndAngle = CGFloat(90 * M_PI/180)
        let blackCircleRect = CGRectMake(50, 550, 30, 30) //location
        
        // create the bezier path
        let blackCirclePath = UIBezierPath()
        
        blackCirclePath.addArcWithCenter(CGPointMake(CGRectGetMidX(blackCircleRect), CGRectGetMidY(blackCircleRect)),
            radius: CGRectGetWidth(blackCircleRect) / 2,
            startAngle: blackCircleStartAngle,
            endAngle: blackCircleEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        let blackCircle = CAShapeLayer()
        blackCircle.path = blackCirclePath.CGPath
        blackCircle.strokeColor = UIColor.blackColor().CGColor
        blackCircle.fillColor = UIColor.blackColor().CGColor
        //blackCircle.fillColor = UIColor.clearColor().CGColor
        blackCircle.lineWidth = 1.0
        blackCircle.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(blackCircle)
        
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEndblackCircle = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndblackCircle.duration = 3.0
        animateStrokeEndblackCircle.fromValue = 0.0
        animateStrokeEndblackCircle.toValue = 1.0
        
        
        // add the animation
        blackCircle.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
        
        
        let markerLines = UIView()
        markerLines.backgroundColor = UIColor.orangeColor()
        markerLines.frame = CGRect(x: 200, y: 10, width: 15, height: 300)
        markerLines.transform = CGAffineTransformMakeRotation(2/3 * fullRotation)
        self.view.addSubview(markerLines)
        UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
            markerLines.backgroundColor = UIColor.orangeColor()
            markerLines.frame = CGRect(x: 200, y: 10, width: 15, height: 10)
            
            }, completion: nil)
        
    }

    
    func blueanimation() {
        
        for loopNumber in 0...10 {
            
            
            let coloredSquare1 = UIView()
            let coloredSquare2 = UIView()
            let coloredSquare3 = UIView()
            
            
            // set background color to blue
            coloredSquare1.backgroundColor = UIColor.redColor()
            coloredSquare2.backgroundColor = UIColor.blueColor()
            coloredSquare3.backgroundColor = UIColor.greenColor()
            
            // set frame (position and size) of the square
            // iOS coordinate system starts at the top left of the screen
            // so this square will be at top left of screen, 50x50pt
            // CG in CGRect stands for Core Graphics
            coloredSquare1.frame = CGRect(x: 0, y: 10, width: 10, height: 20)
            coloredSquare2.frame = CGRect(x: 0, y: 10, width: 10, height: 20)
            coloredSquare3.frame = CGRect(x: 0, y: 10, width: 10, height: 20)
            
            // finally, add the square to the screen
            self.view.addSubview(coloredSquare1)
            self.view.addSubview(coloredSquare2)
            self.view.addSubview(coloredSquare3)
            
            let options = UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat | UIViewAnimationOptions.CurveEaseInOut
            let duration = 1.0
            let delay = 0.0
            let damping = 0.5 // set damping ration
            let velocity = 1.0 // set initial velocity
            let fullRotation = CGFloat(M_PI * 2)
            
            
            UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
                coloredSquare1.backgroundColor = UIColor.redColor()
                coloredSquare2.backgroundColor = UIColor.greenColor()
                coloredSquare3.backgroundColor = UIColor.blueColor()
                
                // for the x-position I entered 320-50 (width of screen - width of the square)
                // if you want, you could just enter 270
                // but I prefer to enter the math as a reminder of what's happenings
                coloredSquare1.frame = CGRect(x: 320-50, y: 20, width: 10, height: 50)
                coloredSquare2.frame = CGRect(x: 320-50, y: 120, width: 10, height: 50)
                coloredSquare3.frame = CGRect(x: 320-50, y: 220, width: 10, height: 50)
                
                }, completion: nil)
            
            
        } //end of RGBColorBlocksloop

        ///Begin Animation
        ///////Animation
        for i in 0...5 {
            
            // create a square
            let square = UIView()
            square.frame = CGRect(x: 55, y: 600, width: 20, height: 20)
            square.backgroundColor = UIColor.blackColor()
            self.view.addSubview(square)
            
            // randomly create a value between 0.0 and 150.0
            let randomYOffset = CGFloat( arc4random_uniform(150))
            
            // for every y-value on the bezier curve
            // add our random y offset so that each individual animation
            // will appear at a different y-position
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 16,y: 16 + randomYOffset))
            path.addCurveToPoint(CGPoint(x: 301, y: 239 + randomYOffset), controlPoint1: CGPoint(x: 136, y: 373 + randomYOffset), controlPoint2: CGPoint(x: 178, y: 110 + randomYOffset))
            
            // create the animation
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.CGPath
            anim.rotationMode = kCAAnimationRotateAuto
            anim.repeatCount = Float.infinity
            //anim.duration = 5.0
            anim.duration = Double(arc4random_uniform(40)+30) / 10
            anim.timeOffset = Double(arc4random_uniform(290))
            
            // add the animation
            square.layer.addAnimation(anim, forKey: "animate position along path")
            
        }
        
        ///draw circle
        let ovalStartAngle = CGFloat(90.01 * M_PI/180)
        let ovalEndAngle = CGFloat(90 * M_PI/180)
        let ovalRect = CGRectMake(100, 400, 75, 75) //location //y was 200
        
        // create the bezier path
        let ovalPath = UIBezierPath()
        
        ovalPath.addArcWithCenter(CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)),
            radius: CGRectGetWidth(ovalRect) / 2,
            startAngle: ovalStartAngle,
            endAngle: ovalEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        let progressLine = CAShapeLayer()
        progressLine.path = ovalPath.CGPath
        progressLine.strokeColor = UIColor.blackColor().CGColor
        progressLine.fillColor = UIColor.blueColor().CGColor
        progressLine.fillColor = UIColor.clearColor().CGColor
        progressLine.lineWidth = 10.0
        progressLine.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(progressLine)
        
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = 3.0
        animateStrokeEnd.fromValue = 0.0
        animateStrokeEnd.toValue = 1.0
        
        
        // add the animation
        progressLine.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
        
        
        
        //////////////// ///draw circle 2
        let halfMoonStartAngle = CGFloat(10.01 * M_PI/180)
        let halfMoonEndAngle = CGFloat(10 * M_PI/180)
        let halfMoonRect = CGRectMake(80, 260, 300, 300) //location
        
        // create the bezier path
        let halfMoonPath = UIBezierPath()
        
        halfMoonPath.addArcWithCenter(CGPointMake(CGRectGetMidX(halfMoonRect), CGRectGetMidY(halfMoonRect)),
            radius: CGRectGetWidth(halfMoonRect) / 2,
            startAngle: halfMoonStartAngle,
            endAngle: halfMoonEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        let halfMoon = CAShapeLayer()
        halfMoon.path = halfMoonPath.CGPath
        halfMoon.strokeColor = UIColor.blackColor().CGColor
        //halfMoon.fillColor = UIColor.redColor().CGColor
        halfMoon.fillColor = UIColor.clearColor().CGColor
        halfMoon.lineWidth = 10.0
        halfMoon.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(halfMoon)
        
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEndTwo = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndTwo.duration = 3.0
        animateStrokeEndTwo.fromValue = 0.0
        animateStrokeEndTwo.toValue = 1.0
        
        
        // add the animation
        halfMoon.addAnimation(animateStrokeEndTwo, forKey: "animate stroke end animation")
        
        /////////yellow circle
        let yellowShapeStartAngle = CGFloat(10.01 * M_PI/180)
        let yellowShapeEndAngle = CGFloat(10 * M_PI/180)
        let yellowShapeRect = CGRectMake(280, 460, 20, 20) //location
        
        let yellowShapePath = UIBezierPath()
        
        
        yellowShapePath.addArcWithCenter(CGPointMake(CGRectGetMidX(yellowShapeRect), CGRectGetMidY(yellowShapeRect)),
            radius: CGRectGetWidth(yellowShapeRect) / 2,
            startAngle: yellowShapeStartAngle,
            endAngle: yellowShapeEndAngle, clockwise: true)
        
        let yellowShape = CAShapeLayer()
        yellowShape.path = yellowShapePath.CGPath
        yellowShape.strokeColor = UIColor.blackColor().CGColor
        yellowShape.fillColor = UIColor.blueColor().CGColor
        yellowShape.lineWidth = 3.0
        yellowShape.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(yellowShape)
        
        let animateStrokeEndThree = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndThree.duration = 3.0
        animateStrokeEndThree.fromValue = 0.0
        animateStrokeEndThree.toValue = 1.0
        
        yellowShape.addAnimation(animateStrokeEndTwo, forKey: "animate stroke end animation")
        
        /////////////
        let yellowShapeTwoStartAngle = CGFloat(10.01 * M_PI/180)
        let yellowShapeTwoEndAngle = CGFloat(10 * M_PI/180)
        let yellowShapeTwoRect = CGRectMake(220, 240, 20, 20) //location
        
        let yellowShapeTwoPath = UIBezierPath()
        
        
        yellowShapeTwoPath.addArcWithCenter(CGPointMake(CGRectGetMidX(yellowShapeTwoRect), CGRectGetMidY(yellowShapeTwoRect)),
            radius: CGRectGetWidth(yellowShapeTwoRect) / 2,
            startAngle: yellowShapeTwoStartAngle,
            endAngle: yellowShapeTwoEndAngle, clockwise: true)
        
        let yellowShapeTwo = CAShapeLayer()
        yellowShapeTwo.path = yellowShapeTwoPath.CGPath
        yellowShapeTwo.strokeColor = UIColor.blackColor().CGColor
        yellowShapeTwo.fillColor = UIColor.blueColor().CGColor
        yellowShapeTwo.lineWidth = 3.0
        yellowShapeTwo.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(yellowShapeTwo)
        
        let animateStrokeEndFour = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndFour.duration = 3.0
        animateStrokeEndFour.fromValue = 0.0
        animateStrokeEndFour.toValue = 1.0
        
        yellowShapeTwo.addAnimation(animateStrokeEndFour, forKey: "animate stroke end animation")
        
        ///////
        /////////////
        let yellowShapeThreeStartAngle = CGFloat(10.01 * M_PI/180)
        let yellowShapeThreeEndAngle = CGFloat(10 * M_PI/180)
        let yellowShapeThreeRect = CGRectMake(220, 600, 20, 20) //location
        
        let yellowShapeThreePath = UIBezierPath()
        
        
        yellowShapeThreePath.addArcWithCenter(CGPointMake(CGRectGetMidX(yellowShapeThreeRect), CGRectGetMidY(yellowShapeThreeRect)),
            radius: CGRectGetWidth(yellowShapeThreeRect) / 2,
            startAngle: yellowShapeThreeStartAngle,
            endAngle: yellowShapeThreeEndAngle, clockwise: true)
        
        let yellowShapeThree = CAShapeLayer()
        yellowShapeThree.path = yellowShapeThreePath.CGPath
        yellowShapeThree.strokeColor = UIColor.blackColor().CGColor
        yellowShapeThree.fillColor = UIColor.yellowColor().CGColor
        yellowShapeThree.lineWidth = 3.0
        yellowShapeThree.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(yellowShapeThree)
        
        let animateStrokeEndFive = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndFive.duration = 3.0
        animateStrokeEndFive.fromValue = 0.0
        animateStrokeEndFive.toValue = 1.0
        
        yellowShapeThree.addAnimation(animateStrokeEndFive, forKey: "animate stroke end animation")
        
        
        /////greencircles
        /////////////
        let greenShapeStartAngle = CGFloat(10.01 * M_PI/180)
        let greenShapeEndAngle = CGFloat(10 * M_PI/180)
        let greenShapeRect = CGRectMake(20, 300, 20, 20) //location
        
        let greenShapePath = UIBezierPath()
        
        
        greenShapePath.addArcWithCenter(CGPointMake(CGRectGetMidX(greenShapeRect), CGRectGetMidY(greenShapeRect)),
            radius: CGRectGetWidth(greenShapeRect) / 2,
            startAngle: greenShapeStartAngle,
            endAngle: greenShapeEndAngle, clockwise: true)
        
        let greenShape = CAShapeLayer()
        greenShape.path = greenShapePath.CGPath
        greenShape.strokeColor = UIColor.blackColor().CGColor
        greenShape.fillColor = UIColor.greenColor().CGColor
        greenShape.lineWidth = 3.0
        greenShape.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(greenShape)
        
        let animateStrokeEndSix = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndSix.duration = 3.0
        animateStrokeEndSix.fromValue = 0.0
        animateStrokeEndSix.toValue = 1.0
        
        greenShape.addAnimation(animateStrokeEndSix, forKey: "animate stroke end animation")
        
        ///     /////greencircles
        /////////////
        let greenShapeTwoStartAngle = CGFloat(10.01 * M_PI/180)
        let greenShapeTwoEndAngle = CGFloat(10 * M_PI/180)
        let greenShapeTwoRect = CGRectMake(120, 300, 20, 20) //location
        
        let greenShapeTwoPath = UIBezierPath()
        
        
        greenShapeTwoPath.addArcWithCenter(CGPointMake(CGRectGetMidX(greenShapeTwoRect), CGRectGetMidY(greenShapeTwoRect)),
            radius: CGRectGetWidth(greenShapeTwoRect) / 2,
            startAngle: greenShapeTwoStartAngle,
            endAngle: greenShapeTwoEndAngle, clockwise: true)
        
        let greenShapeTwo = CAShapeLayer()
        greenShapeTwo.path = greenShapeTwoPath.CGPath
        greenShapeTwo.strokeColor = UIColor.blackColor().CGColor
        greenShapeTwo.fillColor = UIColor.blueColor().CGColor
        greenShapeTwo.lineWidth = 3.0
        greenShapeTwo.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(greenShapeTwo)
        
        let animateStrokeEndSeven = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndSeven.duration = 3.0
        animateStrokeEndSeven.fromValue = 0.0
        animateStrokeEndSeven.toValue = 1.0
        
        greenShapeTwo.addAnimation(animateStrokeEndSeven, forKey: "animate stroke end animation")
        
        ///////gray arc
        
        
        let grayArcPath = UIBezierPath()
        
        let grayArc = CAShapeLayer()
        let grow = CGRect(x: 50, y: 50, width: 100, height: 100)
        grayArc.bounds = grow
        grayArc.position = view.center
        grayArc.cornerRadius = grow.width / 2
        self.view.layer.addSublayer(grayArc)
        grayArc.path = UIBezierPath(ovalInRect: grayArc.bounds).CGPath
        
        grayArc.strokeColor = UIColor.lightGrayColor().CGColor
        grayArc.fillColor = UIColor.clearColor().CGColor
        grayArc.lineWidth = 7.0
        grayArc.lineCap = kCALineCapRound
        
        grayArc.strokeStart = 0
        grayArc.strokeEnd = 0.5
        
        // add the curve to the screen
        
        
        // 3
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 0.7
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1
        
        // 4
        let group = CAAnimationGroup()
        group.animations = [start, end]
        group.duration = 1.5
        group.autoreverses = true
        group.repeatCount = HUGE // repeat forver
        grayArc.addAnimation(group, forKey: nil)
        
        //////grayArc2
        
        
        let grayArc2Path = UIBezierPath()
        
        
        let grayArc2 = CAShapeLayer()
        let grow2 = CGRect(x: 100, y: 100, width: 200, height: 200)
        grayArc2.bounds = grow2
        grayArc2.position = view.center
        grayArc2.cornerRadius = grow2.width / 2
        self.view.layer.addSublayer(grayArc2)
        grayArc2.path = UIBezierPath(ovalInRect: grayArc2.bounds).CGPath
        
        grayArc2.strokeColor = UIColor.lightGrayColor().CGColor
        grayArc2.fillColor = UIColor.clearColor().CGColor
        grayArc2.lineWidth = 7.0
        grayArc2.lineCap = kCALineCapRound
        
        grayArc2.strokeStart = 0
        grayArc2.strokeEnd = 0.5
        
        // add the curve to the screen
        
        
        // 3
        let start2 = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 0.7
        let end2 = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1
        
        // 4
        let group2 = CAAnimationGroup()
        group2.animations = [start, end]
        group2.duration = 1.5
        group2.autoreverses = true
        group2.repeatCount = HUGE // repeat forver
        grayArc2.addAnimation(group, forKey: nil)
        
        ////gray Lines
        
        let grayLine = CAShapeLayer()
        
        
        
        
        grayLine.strokeColor = UIColor.darkGrayColor().CGColor
        grayLine.fillColor = UIColor.clearColor().CGColor
        grayLine.lineWidth = 7.0
        grayLine.lineCap = kCALineCapRound
        
        
        
        // add the curve to the screen
        self.view.layer.addSublayer(grayLine)
        
        let animateStrokeEndgrayLine = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndgrayLine.duration = 3.0
        animateStrokeEndgrayLine.fromValue = 0.0
        animateStrokeEndgrayLine.toValue = 1.0
        
        grayLine.addAnimation(animateStrokeEndgrayLine, forKey: "animate stroke end animation")
        ///   ///// /////black Line
        
        let fullRotation = CGFloat(M_PI * 2)
        
        
        
        let blacksquare = UIView()
        blacksquare.backgroundColor = UIColor.blackColor()
        blacksquare.frame = CGRect(x: 200, y: 200, width: 6, height: 500)
        self.view.addSubview(blacksquare)
        
        let options = UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat | UIViewAnimationOptions.CurveEaseInOut
        let duration = 1.0
        let delay = 0.0
        let damping = 0.5 // set damping ration
        let velocity = 1.0 // set initial velocity
        //let fullRotation = CGFloat(M_PI * 2)
        
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
            blacksquare.backgroundColor = UIColor.blackColor()
            blacksquare.frame = CGRect(x: 420-50, y: 20, width: 10, height: 50)
            
            }, completion: nil)
        
        
        ////colorLines
        
        
        let colorLines = UIView()
        colorLines.backgroundColor = UIColor.lightGrayColor()
        colorLines.frame = CGRect(x: 20, y: 200, width: 20, height: 20)
        self.view.addSubview(colorLines)
        
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
            colorLines.backgroundColor = UIColor.lightGrayColor()
            colorLines.frame = CGRect(x: 200, y: 50, width: 200, height: 10)
            
            }, completion: nil)
        
        
        
        
        let blackCircleStartAngle = CGFloat(90.01 * M_PI/180)
        let blackCircleEndAngle = CGFloat(90 * M_PI/180)
        let blackCircleRect = CGRectMake(50, 550, 30, 30) //location
        
        // create the bezier path
        let blackCirclePath = UIBezierPath()
        
        blackCirclePath.addArcWithCenter(CGPointMake(CGRectGetMidX(blackCircleRect), CGRectGetMidY(blackCircleRect)),
            radius: CGRectGetWidth(blackCircleRect) / 2,
            startAngle: blackCircleStartAngle,
            endAngle: blackCircleEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        let blackCircle = CAShapeLayer()
        blackCircle.path = blackCirclePath.CGPath
        blackCircle.strokeColor = UIColor.blackColor().CGColor
        blackCircle.fillColor = UIColor.blackColor().CGColor
        //blackCircle.fillColor = UIColor.clearColor().CGColor
        blackCircle.lineWidth = 1.0
        blackCircle.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(blackCircle)
        
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEndblackCircle = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndblackCircle.duration = 3.0
        animateStrokeEndblackCircle.fromValue = 0.0
        animateStrokeEndblackCircle.toValue = 1.0
        
        
        // add the animation
        blackCircle.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
        
        
        let markerLines = UIView()
        markerLines.backgroundColor = UIColor.orangeColor()
        markerLines.frame = CGRect(x: 200, y: 10, width: 15, height: 300)
        markerLines.transform = CGAffineTransformMakeRotation(2/3 * fullRotation)
        self.view.addSubview(markerLines)
        UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
            markerLines.backgroundColor = UIColor.orangeColor()
            markerLines.frame = CGRect(x: 200, y: 10, width: 15, height: 10)
            
            }, completion: nil)
        

        
    }
    
    func whiteanimation() {
        for loopNumber in 0...10 {
            
            
            let coloredSquare1 = UIView()
            let coloredSquare2 = UIView()
            let coloredSquare3 = UIView()
            
            
            // set background color to blue
            coloredSquare1.backgroundColor = UIColor.redColor()
            coloredSquare2.backgroundColor = UIColor.blueColor()
            coloredSquare3.backgroundColor = UIColor.greenColor()
            
            // set frame (position and size) of the square
            // iOS coordinate system starts at the top left of the screen
            // so this square will be at top left of screen, 50x50pt
            // CG in CGRect stands for Core Graphics
            coloredSquare1.frame = CGRect(x: 0, y: 10, width: 10, height: 20)
            coloredSquare2.frame = CGRect(x: 0, y: 10, width: 10, height: 20)
            coloredSquare3.frame = CGRect(x: 0, y: 10, width: 10, height: 20)
            
            // finally, add the square to the screen
            self.view.addSubview(coloredSquare1)
            self.view.addSubview(coloredSquare2)
            self.view.addSubview(coloredSquare3)
            
            let options = UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat | UIViewAnimationOptions.CurveEaseInOut
            let duration = 1.0
            let delay = 0.0
            let damping = 0.5 // set damping ration
            let velocity = 1.0 // set initial velocity
            let fullRotation = CGFloat(M_PI * 2)
            
            
            UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
                coloredSquare1.backgroundColor = UIColor.redColor()
                coloredSquare2.backgroundColor = UIColor.greenColor()
                coloredSquare3.backgroundColor = UIColor.blueColor()
                
                // for the x-position I entered 320-50 (width of screen - width of the square)
                // if you want, you could just enter 270
                // but I prefer to enter the math as a reminder of what's happenings
                coloredSquare1.frame = CGRect(x: 320-50, y: 20, width: 10, height: 50)
                coloredSquare2.frame = CGRect(x: 320-50, y: 120, width: 10, height: 50)
                coloredSquare3.frame = CGRect(x: 320-50, y: 220, width: 10, height: 50)
                
                }, completion: nil)
            
            
        } //end of RGBColorBlocksloop
        
        
        ///Begin Animation
        ///////Animation
        for i in 0...5 {
            
            // create a square
            let square = UIView()
            square.frame = CGRect(x: 55, y: 600, width: 20, height: 20)
            square.backgroundColor = UIColor.blackColor()
            self.view.addSubview(square)
            
            // randomly create a value between 0.0 and 150.0
            let randomYOffset = CGFloat( arc4random_uniform(150))
            
            // for every y-value on the bezier curve
            // add our random y offset so that each individual animation
            // will appear at a different y-position
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 16,y: 16 + randomYOffset))
            path.addCurveToPoint(CGPoint(x: 301, y: 239 + randomYOffset), controlPoint1: CGPoint(x: 136, y: 373 + randomYOffset), controlPoint2: CGPoint(x: 178, y: 110 + randomYOffset))
            
            // create the animation
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.CGPath
            anim.rotationMode = kCAAnimationRotateAuto
            anim.repeatCount = Float.infinity
            //anim.duration = 5.0
            anim.duration = Double(arc4random_uniform(40)+30) / 10
            anim.timeOffset = Double(arc4random_uniform(290))
            
            // add the animation
            square.layer.addAnimation(anim, forKey: "animate position along path")
            
        }
        
        ///draw circle
        let ovalStartAngle = CGFloat(90.01 * M_PI/180)
        let ovalEndAngle = CGFloat(90 * M_PI/180)
        let ovalRect = CGRectMake(100, 400, 75, 75) //location //y was 200
        
        // create the bezier path
        let ovalPath = UIBezierPath()
        
        ovalPath.addArcWithCenter(CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)),
            radius: CGRectGetWidth(ovalRect) / 2,
            startAngle: ovalStartAngle,
            endAngle: ovalEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        let progressLine = CAShapeLayer()
        progressLine.path = ovalPath.CGPath
        progressLine.strokeColor = UIColor.blackColor().CGColor
        progressLine.fillColor = UIColor.blueColor().CGColor
        progressLine.fillColor = UIColor.clearColor().CGColor
        progressLine.lineWidth = 10.0
        progressLine.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(progressLine)
        
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = 3.0
        animateStrokeEnd.fromValue = 0.0
        animateStrokeEnd.toValue = 1.0
        
        
        // add the animation
        progressLine.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
        
        
        
        //////////////// ///draw circle 2
        let halfMoonStartAngle = CGFloat(10.01 * M_PI/180)
        let halfMoonEndAngle = CGFloat(10 * M_PI/180)
        let halfMoonRect = CGRectMake(80, 260, 300, 300) //location
        
        // create the bezier path
        let halfMoonPath = UIBezierPath()
        
        halfMoonPath.addArcWithCenter(CGPointMake(CGRectGetMidX(halfMoonRect), CGRectGetMidY(halfMoonRect)),
            radius: CGRectGetWidth(halfMoonRect) / 2,
            startAngle: halfMoonStartAngle,
            endAngle: halfMoonEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        let halfMoon = CAShapeLayer()
        halfMoon.path = halfMoonPath.CGPath
        halfMoon.strokeColor = UIColor.blackColor().CGColor
        //halfMoon.fillColor = UIColor.redColor().CGColor
        halfMoon.fillColor = UIColor.clearColor().CGColor
        halfMoon.lineWidth = 10.0
        halfMoon.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(halfMoon)
        
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEndTwo = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndTwo.duration = 3.0
        animateStrokeEndTwo.fromValue = 0.0
        animateStrokeEndTwo.toValue = 1.0
        
        
        // add the animation
        halfMoon.addAnimation(animateStrokeEndTwo, forKey: "animate stroke end animation")
        
        /////////yellow circle
        let yellowShapeStartAngle = CGFloat(10.01 * M_PI/180)
        let yellowShapeEndAngle = CGFloat(10 * M_PI/180)
        let yellowShapeRect = CGRectMake(280, 460, 20, 20) //location
        
        let yellowShapePath = UIBezierPath()
        
        
        yellowShapePath.addArcWithCenter(CGPointMake(CGRectGetMidX(yellowShapeRect), CGRectGetMidY(yellowShapeRect)),
            radius: CGRectGetWidth(yellowShapeRect) / 2,
            startAngle: yellowShapeStartAngle,
            endAngle: yellowShapeEndAngle, clockwise: true)
        
        let yellowShape = CAShapeLayer()
        yellowShape.path = yellowShapePath.CGPath
        yellowShape.strokeColor = UIColor.blackColor().CGColor
        yellowShape.fillColor = UIColor.yellowColor().CGColor
        yellowShape.lineWidth = 3.0
        yellowShape.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(yellowShape)
        
        let animateStrokeEndThree = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndThree.duration = 3.0
        animateStrokeEndThree.fromValue = 0.0
        animateStrokeEndThree.toValue = 1.0
        
        yellowShape.addAnimation(animateStrokeEndTwo, forKey: "animate stroke end animation")
        
        /////////////
        let yellowShapeTwoStartAngle = CGFloat(10.01 * M_PI/180)
        let yellowShapeTwoEndAngle = CGFloat(10 * M_PI/180)
        let yellowShapeTwoRect = CGRectMake(220, 240, 20, 20) //location
        
        let yellowShapeTwoPath = UIBezierPath()
        
        
        yellowShapeTwoPath.addArcWithCenter(CGPointMake(CGRectGetMidX(yellowShapeTwoRect), CGRectGetMidY(yellowShapeTwoRect)),
            radius: CGRectGetWidth(yellowShapeTwoRect) / 2,
            startAngle: yellowShapeTwoStartAngle,
            endAngle: yellowShapeTwoEndAngle, clockwise: true)
        
        let yellowShapeTwo = CAShapeLayer()
        yellowShapeTwo.path = yellowShapeTwoPath.CGPath
        yellowShapeTwo.strokeColor = UIColor.blackColor().CGColor
        yellowShapeTwo.fillColor = UIColor.yellowColor().CGColor
        yellowShapeTwo.lineWidth = 3.0
        yellowShapeTwo.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(yellowShapeTwo)
        
        let animateStrokeEndFour = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndFour.duration = 3.0
        animateStrokeEndFour.fromValue = 0.0
        animateStrokeEndFour.toValue = 1.0
        
        yellowShapeTwo.addAnimation(animateStrokeEndFour, forKey: "animate stroke end animation")
        
        ///////
        /////////////
        let yellowShapeThreeStartAngle = CGFloat(10.01 * M_PI/180)
        let yellowShapeThreeEndAngle = CGFloat(10 * M_PI/180)
        let yellowShapeThreeRect = CGRectMake(220, 600, 20, 20) //location
        
        let yellowShapeThreePath = UIBezierPath()
        
        
        yellowShapeThreePath.addArcWithCenter(CGPointMake(CGRectGetMidX(yellowShapeThreeRect), CGRectGetMidY(yellowShapeThreeRect)),
            radius: CGRectGetWidth(yellowShapeThreeRect) / 2,
            startAngle: yellowShapeThreeStartAngle,
            endAngle: yellowShapeThreeEndAngle, clockwise: true)
        
        let yellowShapeThree = CAShapeLayer()
        yellowShapeThree.path = yellowShapeThreePath.CGPath
        yellowShapeThree.strokeColor = UIColor.blackColor().CGColor
        yellowShapeThree.fillColor = UIColor.yellowColor().CGColor
        yellowShapeThree.lineWidth = 3.0
        yellowShapeThree.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(yellowShapeThree)
        
        let animateStrokeEndFive = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndFive.duration = 3.0
        animateStrokeEndFive.fromValue = 0.0
        animateStrokeEndFive.toValue = 1.0
        
        yellowShapeThree.addAnimation(animateStrokeEndFive, forKey: "animate stroke end animation")
        
        
        /////greencircles
        /////////////
        let greenShapeStartAngle = CGFloat(10.01 * M_PI/180)
        let greenShapeEndAngle = CGFloat(10 * M_PI/180)
        let greenShapeRect = CGRectMake(20, 300, 20, 20) //location
        
        let greenShapePath = UIBezierPath()
        
        
        greenShapePath.addArcWithCenter(CGPointMake(CGRectGetMidX(greenShapeRect), CGRectGetMidY(greenShapeRect)),
            radius: CGRectGetWidth(greenShapeRect) / 2,
            startAngle: greenShapeStartAngle,
            endAngle: greenShapeEndAngle, clockwise: true)
        
        let greenShape = CAShapeLayer()
        greenShape.path = greenShapePath.CGPath
        greenShape.strokeColor = UIColor.blackColor().CGColor
        greenShape.fillColor = UIColor.greenColor().CGColor
        greenShape.lineWidth = 3.0
        greenShape.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(greenShape)
        
        let animateStrokeEndSix = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndSix.duration = 3.0
        animateStrokeEndSix.fromValue = 0.0
        animateStrokeEndSix.toValue = 1.0
        
        greenShape.addAnimation(animateStrokeEndSix, forKey: "animate stroke end animation")
        
        ///     /////greencircles
        /////////////
        let greenShapeTwoStartAngle = CGFloat(10.01 * M_PI/180)
        let greenShapeTwoEndAngle = CGFloat(10 * M_PI/180)
        let greenShapeTwoRect = CGRectMake(120, 300, 20, 20) //location
        
        let greenShapeTwoPath = UIBezierPath()
        
        
        greenShapeTwoPath.addArcWithCenter(CGPointMake(CGRectGetMidX(greenShapeTwoRect), CGRectGetMidY(greenShapeTwoRect)),
            radius: CGRectGetWidth(greenShapeTwoRect) / 2,
            startAngle: greenShapeTwoStartAngle,
            endAngle: greenShapeTwoEndAngle, clockwise: true)
        
        let greenShapeTwo = CAShapeLayer()
        greenShapeTwo.path = greenShapeTwoPath.CGPath
        greenShapeTwo.strokeColor = UIColor.blackColor().CGColor
        greenShapeTwo.fillColor = UIColor.greenColor().CGColor
        greenShapeTwo.lineWidth = 3.0
        greenShapeTwo.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(greenShapeTwo)
        
        let animateStrokeEndSeven = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndSeven.duration = 3.0
        animateStrokeEndSeven.fromValue = 0.0
        animateStrokeEndSeven.toValue = 1.0
        
        greenShapeTwo.addAnimation(animateStrokeEndSeven, forKey: "animate stroke end animation")
        
        ///////gray arc
        
        
        let grayArcPath = UIBezierPath()
        
        let grayArc = CAShapeLayer()
        let grow = CGRect(x: 50, y: 50, width: 100, height: 100)
        grayArc.bounds = grow
        grayArc.position = view.center
        grayArc.cornerRadius = grow.width / 2
        self.view.layer.addSublayer(grayArc)
        grayArc.path = UIBezierPath(ovalInRect: grayArc.bounds).CGPath
        
        grayArc.strokeColor = UIColor.lightGrayColor().CGColor
        grayArc.fillColor = UIColor.clearColor().CGColor
        grayArc.lineWidth = 7.0
        grayArc.lineCap = kCALineCapRound
        
        grayArc.strokeStart = 0
        grayArc.strokeEnd = 0.5
        
        // add the curve to the screen
        
        
        // 3
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 0.7
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1
        
        // 4
        let group = CAAnimationGroup()
        group.animations = [start, end]
        group.duration = 1.5
        group.autoreverses = true
        group.repeatCount = HUGE // repeat forver
        grayArc.addAnimation(group, forKey: nil)
        
        //////grayArc2
        
        
        let grayArc2Path = UIBezierPath()
        
        
        let grayArc2 = CAShapeLayer()
        let grow2 = CGRect(x: 100, y: 100, width: 200, height: 200)
        grayArc2.bounds = grow2
        grayArc2.position = view.center
        grayArc2.cornerRadius = grow2.width / 2
        self.view.layer.addSublayer(grayArc2)
        grayArc2.path = UIBezierPath(ovalInRect: grayArc2.bounds).CGPath
        
        grayArc2.strokeColor = UIColor.lightGrayColor().CGColor
        grayArc2.fillColor = UIColor.clearColor().CGColor
        grayArc2.lineWidth = 7.0
        grayArc2.lineCap = kCALineCapRound
        
        grayArc2.strokeStart = 0
        grayArc2.strokeEnd = 0.5
        
        // add the curve to the screen
        
        
        // 3
        let start2 = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 0.7
        let end2 = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1
        
        // 4
        let group2 = CAAnimationGroup()
        group2.animations = [start, end]
        group2.duration = 1.5
        group2.autoreverses = true
        group2.repeatCount = HUGE // repeat forver
        grayArc2.addAnimation(group, forKey: nil)
        
        ////gray Lines
        
        let grayLine = CAShapeLayer()
        
        
        
        
        grayLine.strokeColor = UIColor.darkGrayColor().CGColor
        grayLine.fillColor = UIColor.clearColor().CGColor
        grayLine.lineWidth = 7.0
        grayLine.lineCap = kCALineCapRound
        
        
        
        // add the curve to the screen
        self.view.layer.addSublayer(grayLine)
        
        let animateStrokeEndgrayLine = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndgrayLine.duration = 3.0
        animateStrokeEndgrayLine.fromValue = 0.0
        animateStrokeEndgrayLine.toValue = 1.0
        
        grayLine.addAnimation(animateStrokeEndgrayLine, forKey: "animate stroke end animation")
        ///   ///// /////black Line
        
        let fullRotation = CGFloat(M_PI * 2)
        
        
        
        let blacksquare = UIView()
        blacksquare.backgroundColor = UIColor.blackColor()
        blacksquare.frame = CGRect(x: 200, y: 200, width: 6, height: 500)
        self.view.addSubview(blacksquare)
        
        let options = UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat | UIViewAnimationOptions.CurveEaseInOut
        let duration = 1.0
        let delay = 0.0
        let damping = 0.5 // set damping ration
        let velocity = 1.0 // set initial velocity
        //let fullRotation = CGFloat(M_PI * 2)
        
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
            blacksquare.backgroundColor = UIColor.blackColor()
            blacksquare.frame = CGRect(x: 420-50, y: 20, width: 10, height: 50)
            
            }, completion: nil)
        
        
        ////colorLines
        
        
        let colorLines = UIView()
        colorLines.backgroundColor = UIColor.lightGrayColor()
        colorLines.frame = CGRect(x: 20, y: 200, width: 20, height: 20)
        self.view.addSubview(colorLines)
        
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
            colorLines.backgroundColor = UIColor.lightGrayColor()
            colorLines.frame = CGRect(x: 200, y: 50, width: 200, height: 10)
            
            }, completion: nil)
        
        
        
        
        let blackCircleStartAngle = CGFloat(90.01 * M_PI/180)
        let blackCircleEndAngle = CGFloat(90 * M_PI/180)
        let blackCircleRect = CGRectMake(50, 550, 30, 30) //location
        
        // create the bezier path
        let blackCirclePath = UIBezierPath()
        
        blackCirclePath.addArcWithCenter(CGPointMake(CGRectGetMidX(blackCircleRect), CGRectGetMidY(blackCircleRect)),
            radius: CGRectGetWidth(blackCircleRect) / 2,
            startAngle: blackCircleStartAngle,
            endAngle: blackCircleEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        let blackCircle = CAShapeLayer()
        blackCircle.path = blackCirclePath.CGPath
        blackCircle.strokeColor = UIColor.blackColor().CGColor
        blackCircle.fillColor = UIColor.blackColor().CGColor
        //blackCircle.fillColor = UIColor.clearColor().CGColor
        blackCircle.lineWidth = 1.0
        blackCircle.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(blackCircle)
        
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEndblackCircle = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndblackCircle.duration = 3.0
        animateStrokeEndblackCircle.fromValue = 0.0
        animateStrokeEndblackCircle.toValue = 1.0
        
        
        // add the animation
        blackCircle.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
        
        
        let markerLines = UIView()
        markerLines.backgroundColor = UIColor.orangeColor()
        markerLines.frame = CGRect(x: 200, y: 10, width: 15, height: 300)
        markerLines.transform = CGAffineTransformMakeRotation(2/3 * fullRotation)
        self.view.addSubview(markerLines)
        UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
            markerLines.backgroundColor = UIColor.orangeColor()
            markerLines.frame = CGRect(x: 200, y: 10, width: 15, height: 10)
            
            }, completion: nil)
        


    }
    
    func redblueanimation() {
        for loopNumber in 0...10 {
            
            
            let coloredSquare1 = UIView()
            let coloredSquare2 = UIView()
            let coloredSquare3 = UIView()
            
            
            // set background color to blue
            coloredSquare1.backgroundColor = UIColor.redColor()
            coloredSquare2.backgroundColor = UIColor.blueColor()
            coloredSquare3.backgroundColor = UIColor.greenColor()
            
            // set frame (position and size) of the square
            // iOS coordinate system starts at the top left of the screen
            // so this square will be at top left of screen, 50x50pt
            // CG in CGRect stands for Core Graphics
            coloredSquare1.frame = CGRect(x: 0, y: 10, width: 10, height: 20)
            coloredSquare2.frame = CGRect(x: 0, y: 10, width: 10, height: 20)
            coloredSquare3.frame = CGRect(x: 0, y: 10, width: 10, height: 20)
            
            // finally, add the square to the screen
            self.view.addSubview(coloredSquare1)
            self.view.addSubview(coloredSquare2)
            self.view.addSubview(coloredSquare3)
            
            let options = UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat | UIViewAnimationOptions.CurveEaseInOut
            let duration = 1.0
            let delay = 0.0
            let damping = 0.5 // set damping ration
            let velocity = 1.0 // set initial velocity
            let fullRotation = CGFloat(M_PI * 2)
            
            
            UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
                coloredSquare1.backgroundColor = UIColor.redColor()
                coloredSquare2.backgroundColor = UIColor.greenColor()
                coloredSquare3.backgroundColor = UIColor.blueColor()
                
                // for the x-position I entered 320-50 (width of screen - width of the square)
                // if you want, you could just enter 270
                // but I prefer to enter the math as a reminder of what's happenings
                coloredSquare1.frame = CGRect(x: 320-50, y: 20, width: 10, height: 50)
                coloredSquare2.frame = CGRect(x: 320-50, y: 120, width: 10, height: 50)
                coloredSquare3.frame = CGRect(x: 320-50, y: 220, width: 10, height: 50)
                
                }, completion: nil)
            
            
        } //end of RGBColorBlocksloop
        
        ///Begin Animation
        ///////Animation
        for i in 0...5 {
            
            // create a square
            let square = UIView()
            square.frame = CGRect(x: 55, y: 600, width: 20, height: 20)
            square.backgroundColor = UIColor.blackColor()
            self.view.addSubview(square)
            
            // randomly create a value between 0.0 and 150.0
            let randomYOffset = CGFloat( arc4random_uniform(150))
            
            // for every y-value on the bezier curve
            // add our random y offset so that each individual animation
            // will appear at a different y-position
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 16,y: 16 + randomYOffset))
            path.addCurveToPoint(CGPoint(x: 301, y: 239 + randomYOffset), controlPoint1: CGPoint(x: 136, y: 373 + randomYOffset), controlPoint2: CGPoint(x: 178, y: 110 + randomYOffset))
            
            // create the animation
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.CGPath
            anim.rotationMode = kCAAnimationRotateAuto
            anim.repeatCount = Float.infinity
            //anim.duration = 5.0
            anim.duration = Double(arc4random_uniform(40)+30) / 10
            anim.timeOffset = Double(arc4random_uniform(290))
            
            // add the animation
            square.layer.addAnimation(anim, forKey: "animate position along path")
            
        }
        
        ///draw circle
        let ovalStartAngle = CGFloat(90.01 * M_PI/180)
        let ovalEndAngle = CGFloat(90 * M_PI/180)
        let ovalRect = CGRectMake(100, 400, 75, 75) //location //y was 200
        
        // create the bezier path
        let ovalPath = UIBezierPath()
        
        ovalPath.addArcWithCenter(CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)),
            radius: CGRectGetWidth(ovalRect) / 2,
            startAngle: ovalStartAngle,
            endAngle: ovalEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        let progressLine = CAShapeLayer()
        progressLine.path = ovalPath.CGPath
        progressLine.strokeColor = UIColor.blackColor().CGColor
        progressLine.fillColor = UIColor.blueColor().CGColor
        progressLine.fillColor = UIColor.clearColor().CGColor
        progressLine.lineWidth = 10.0
        progressLine.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(progressLine)
        
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = 3.0
        animateStrokeEnd.fromValue = 0.0
        animateStrokeEnd.toValue = 1.0
        
        
        // add the animation
        progressLine.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
        
        
        
        //////////////// ///draw circle 2
        let halfMoonStartAngle = CGFloat(10.01 * M_PI/180)
        let halfMoonEndAngle = CGFloat(10 * M_PI/180)
        let halfMoonRect = CGRectMake(80, 260, 300, 300) //location
        
        // create the bezier path
        let halfMoonPath = UIBezierPath()
        
        halfMoonPath.addArcWithCenter(CGPointMake(CGRectGetMidX(halfMoonRect), CGRectGetMidY(halfMoonRect)),
            radius: CGRectGetWidth(halfMoonRect) / 2,
            startAngle: halfMoonStartAngle,
            endAngle: halfMoonEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        let halfMoon = CAShapeLayer()
        halfMoon.path = halfMoonPath.CGPath
        halfMoon.strokeColor = UIColor.blackColor().CGColor
        //halfMoon.fillColor = UIColor.redColor().CGColor
        halfMoon.fillColor = UIColor.clearColor().CGColor
        halfMoon.lineWidth = 10.0
        halfMoon.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(halfMoon)
        
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEndTwo = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndTwo.duration = 3.0
        animateStrokeEndTwo.fromValue = 0.0
        animateStrokeEndTwo.toValue = 1.0
        
        
        // add the animation
        halfMoon.addAnimation(animateStrokeEndTwo, forKey: "animate stroke end animation")
        
        /////////yellow circle
        let yellowShapeStartAngle = CGFloat(10.01 * M_PI/180)
        let yellowShapeEndAngle = CGFloat(10 * M_PI/180)
        let yellowShapeRect = CGRectMake(280, 460, 20, 20) //location
        
        let yellowShapePath = UIBezierPath()
        
        
        yellowShapePath.addArcWithCenter(CGPointMake(CGRectGetMidX(yellowShapeRect), CGRectGetMidY(yellowShapeRect)),
            radius: CGRectGetWidth(yellowShapeRect) / 2,
            startAngle: yellowShapeStartAngle,
            endAngle: yellowShapeEndAngle, clockwise: true)
        
        let yellowShape = CAShapeLayer()
        yellowShape.path = yellowShapePath.CGPath
        yellowShape.strokeColor = UIColor.blackColor().CGColor
        yellowShape.fillColor = UIColor.yellowColor().CGColor
        yellowShape.lineWidth = 3.0
        yellowShape.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(yellowShape)
        
        let animateStrokeEndThree = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndThree.duration = 3.0
        animateStrokeEndThree.fromValue = 0.0
        animateStrokeEndThree.toValue = 1.0
        
        yellowShape.addAnimation(animateStrokeEndTwo, forKey: "animate stroke end animation")
        
        /////////////
        let yellowShapeTwoStartAngle = CGFloat(10.01 * M_PI/180)
        let yellowShapeTwoEndAngle = CGFloat(10 * M_PI/180)
        let yellowShapeTwoRect = CGRectMake(220, 240, 20, 20) //location
        
        let yellowShapeTwoPath = UIBezierPath()
        
        
        yellowShapeTwoPath.addArcWithCenter(CGPointMake(CGRectGetMidX(yellowShapeTwoRect), CGRectGetMidY(yellowShapeTwoRect)),
            radius: CGRectGetWidth(yellowShapeTwoRect) / 2,
            startAngle: yellowShapeTwoStartAngle,
            endAngle: yellowShapeTwoEndAngle, clockwise: true)
        
        let yellowShapeTwo = CAShapeLayer()
        yellowShapeTwo.path = yellowShapeTwoPath.CGPath
        yellowShapeTwo.strokeColor = UIColor.blackColor().CGColor
        yellowShapeTwo.fillColor = UIColor.yellowColor().CGColor
        yellowShapeTwo.lineWidth = 3.0
        yellowShapeTwo.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(yellowShapeTwo)
        
        let animateStrokeEndFour = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndFour.duration = 3.0
        animateStrokeEndFour.fromValue = 0.0
        animateStrokeEndFour.toValue = 1.0
        
        yellowShapeTwo.addAnimation(animateStrokeEndFour, forKey: "animate stroke end animation")
        
        ///////
        /////////////
        let yellowShapeThreeStartAngle = CGFloat(10.01 * M_PI/180)
        let yellowShapeThreeEndAngle = CGFloat(10 * M_PI/180)
        let yellowShapeThreeRect = CGRectMake(220, 600, 20, 20) //location
        
        let yellowShapeThreePath = UIBezierPath()
        
        
        yellowShapeThreePath.addArcWithCenter(CGPointMake(CGRectGetMidX(yellowShapeThreeRect), CGRectGetMidY(yellowShapeThreeRect)),
            radius: CGRectGetWidth(yellowShapeThreeRect) / 2,
            startAngle: yellowShapeThreeStartAngle,
            endAngle: yellowShapeThreeEndAngle, clockwise: true)
        
        let yellowShapeThree = CAShapeLayer()
        yellowShapeThree.path = yellowShapeThreePath.CGPath
        yellowShapeThree.strokeColor = UIColor.blackColor().CGColor
        yellowShapeThree.fillColor = UIColor.yellowColor().CGColor
        yellowShapeThree.lineWidth = 3.0
        yellowShapeThree.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(yellowShapeThree)
        
        let animateStrokeEndFive = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndFive.duration = 3.0
        animateStrokeEndFive.fromValue = 0.0
        animateStrokeEndFive.toValue = 1.0
        
        yellowShapeThree.addAnimation(animateStrokeEndFive, forKey: "animate stroke end animation")
        
        
        /////greencircles
        /////////////
        let greenShapeStartAngle = CGFloat(10.01 * M_PI/180)
        let greenShapeEndAngle = CGFloat(10 * M_PI/180)
        let greenShapeRect = CGRectMake(20, 300, 20, 20) //location
        
        let greenShapePath = UIBezierPath()
        
        
        greenShapePath.addArcWithCenter(CGPointMake(CGRectGetMidX(greenShapeRect), CGRectGetMidY(greenShapeRect)),
            radius: CGRectGetWidth(greenShapeRect) / 2,
            startAngle: greenShapeStartAngle,
            endAngle: greenShapeEndAngle, clockwise: true)
        
        let greenShape = CAShapeLayer()
        greenShape.path = greenShapePath.CGPath
        greenShape.strokeColor = UIColor.blackColor().CGColor
        greenShape.fillColor = UIColor.greenColor().CGColor
        greenShape.lineWidth = 3.0
        greenShape.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(greenShape)
        
        let animateStrokeEndSix = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndSix.duration = 3.0
        animateStrokeEndSix.fromValue = 0.0
        animateStrokeEndSix.toValue = 1.0
        
        greenShape.addAnimation(animateStrokeEndSix, forKey: "animate stroke end animation")
        
        ///     /////greencircles
        /////////////
        let greenShapeTwoStartAngle = CGFloat(10.01 * M_PI/180)
        let greenShapeTwoEndAngle = CGFloat(10 * M_PI/180)
        let greenShapeTwoRect = CGRectMake(120, 300, 20, 20) //location
        
        let greenShapeTwoPath = UIBezierPath()
        
        
        greenShapeTwoPath.addArcWithCenter(CGPointMake(CGRectGetMidX(greenShapeTwoRect), CGRectGetMidY(greenShapeTwoRect)),
            radius: CGRectGetWidth(greenShapeTwoRect) / 2,
            startAngle: greenShapeTwoStartAngle,
            endAngle: greenShapeTwoEndAngle, clockwise: true)
        
        let greenShapeTwo = CAShapeLayer()
        greenShapeTwo.path = greenShapeTwoPath.CGPath
        greenShapeTwo.strokeColor = UIColor.blackColor().CGColor
        greenShapeTwo.fillColor = UIColor.greenColor().CGColor
        greenShapeTwo.lineWidth = 3.0
        greenShapeTwo.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(greenShapeTwo)
        
        let animateStrokeEndSeven = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndSeven.duration = 3.0
        animateStrokeEndSeven.fromValue = 0.0
        animateStrokeEndSeven.toValue = 1.0
        
        greenShapeTwo.addAnimation(animateStrokeEndSeven, forKey: "animate stroke end animation")
        
        ///////gray arc
        
        
        let grayArcPath = UIBezierPath()
        
        let grayArc = CAShapeLayer()
        let grow = CGRect(x: 50, y: 50, width: 100, height: 100)
        grayArc.bounds = grow
        grayArc.position = view.center
        grayArc.cornerRadius = grow.width / 2
        self.view.layer.addSublayer(grayArc)
        grayArc.path = UIBezierPath(ovalInRect: grayArc.bounds).CGPath
        
        grayArc.strokeColor = UIColor.lightGrayColor().CGColor
        grayArc.fillColor = UIColor.clearColor().CGColor
        grayArc.lineWidth = 7.0
        grayArc.lineCap = kCALineCapRound
        
        grayArc.strokeStart = 0
        grayArc.strokeEnd = 0.5
        
        // add the curve to the screen
        
        
        // 3
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 0.7
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1
        
        // 4
        let group = CAAnimationGroup()
        group.animations = [start, end]
        group.duration = 1.5
        group.autoreverses = true
        group.repeatCount = HUGE // repeat forver
        grayArc.addAnimation(group, forKey: nil)
        
        //////grayArc2
        
        
        let grayArc2Path = UIBezierPath()
        
        
        let grayArc2 = CAShapeLayer()
        let grow2 = CGRect(x: 100, y: 100, width: 200, height: 200)
        grayArc2.bounds = grow2
        grayArc2.position = view.center
        grayArc2.cornerRadius = grow2.width / 2
        self.view.layer.addSublayer(grayArc2)
        grayArc2.path = UIBezierPath(ovalInRect: grayArc2.bounds).CGPath
        
        grayArc2.strokeColor = UIColor.lightGrayColor().CGColor
        grayArc2.fillColor = UIColor.clearColor().CGColor
        grayArc2.lineWidth = 7.0
        grayArc2.lineCap = kCALineCapRound
        
        grayArc2.strokeStart = 0
        grayArc2.strokeEnd = 0.5
        
        // add the curve to the screen
        
        
        // 3
        let start2 = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 0.7
        let end2 = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1
        
        // 4
        let group2 = CAAnimationGroup()
        group2.animations = [start, end]
        group2.duration = 1.5
        group2.autoreverses = true
        group2.repeatCount = HUGE // repeat forver
        grayArc2.addAnimation(group, forKey: nil)
        
        ////gray Lines
        
        let grayLine = CAShapeLayer()
        
        
        
        
        grayLine.strokeColor = UIColor.darkGrayColor().CGColor
        grayLine.fillColor = UIColor.clearColor().CGColor
        grayLine.lineWidth = 7.0
        grayLine.lineCap = kCALineCapRound
        
        
        
        // add the curve to the screen
        self.view.layer.addSublayer(grayLine)
        
        let animateStrokeEndgrayLine = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndgrayLine.duration = 3.0
        animateStrokeEndgrayLine.fromValue = 0.0
        animateStrokeEndgrayLine.toValue = 1.0
        
        grayLine.addAnimation(animateStrokeEndgrayLine, forKey: "animate stroke end animation")
        ///   ///// /////black Line
        
        let fullRotation = CGFloat(M_PI * 2)
        
        
        
        let blacksquare = UIView()
        blacksquare.backgroundColor = UIColor.blackColor()
        blacksquare.frame = CGRect(x: 200, y: 200, width: 6, height: 500)
        self.view.addSubview(blacksquare)
        
        let options = UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat | UIViewAnimationOptions.CurveEaseInOut
        let duration = 1.0
        let delay = 0.0
        let damping = 0.5 // set damping ration
        let velocity = 1.0 // set initial velocity
        //let fullRotation = CGFloat(M_PI * 2)
        
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
            blacksquare.backgroundColor = UIColor.blackColor()
            blacksquare.frame = CGRect(x: 420-50, y: 20, width: 10, height: 50)
            
            }, completion: nil)
        
        
        ////colorLines
        
        
        let colorLines = UIView()
        colorLines.backgroundColor = UIColor.lightGrayColor()
        colorLines.frame = CGRect(x: 20, y: 200, width: 20, height: 20)
        self.view.addSubview(colorLines)
        
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
            colorLines.backgroundColor = UIColor.lightGrayColor()
            colorLines.frame = CGRect(x: 200, y: 50, width: 200, height: 10)
            
            }, completion: nil)
        
        
        
        
        let blackCircleStartAngle = CGFloat(90.01 * M_PI/180)
        let blackCircleEndAngle = CGFloat(90 * M_PI/180)
        let blackCircleRect = CGRectMake(50, 550, 30, 30) //location
        
        // create the bezier path
        let blackCirclePath = UIBezierPath()
        
        blackCirclePath.addArcWithCenter(CGPointMake(CGRectGetMidX(blackCircleRect), CGRectGetMidY(blackCircleRect)),
            radius: CGRectGetWidth(blackCircleRect) / 2,
            startAngle: blackCircleStartAngle,
            endAngle: blackCircleEndAngle, clockwise: true)
        
        // create an object that represents how the curve
        // should be presented on the screen
        let blackCircle = CAShapeLayer()
        blackCircle.path = blackCirclePath.CGPath
        blackCircle.strokeColor = UIColor.blackColor().CGColor
        blackCircle.fillColor = UIColor.blackColor().CGColor
        //blackCircle.fillColor = UIColor.clearColor().CGColor
        blackCircle.lineWidth = 1.0
        blackCircle.lineCap = kCALineCapRound
        
        // add the curve to the screen
        self.view.layer.addSublayer(blackCircle)
        
        // create a basic animation that animates the value 'strokeEnd'
        // from 0.0 to 1.0 over 3.0 seconds
        let animateStrokeEndblackCircle = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEndblackCircle.duration = 3.0
        animateStrokeEndblackCircle.fromValue = 0.0
        animateStrokeEndblackCircle.toValue = 1.0
        
        
        // add the animation
        blackCircle.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
        
        
        let markerLines = UIView()
        markerLines.backgroundColor = UIColor.orangeColor()
        markerLines.frame = CGRect(x: 200, y: 10, width: 15, height: 300)
        markerLines.transform = CGAffineTransformMakeRotation(2/3 * fullRotation)
        self.view.addSubview(markerLines)
        UIView.animateWithDuration(1.0, delay: 0.0, options: options, animations: {
            markerLines.backgroundColor = UIColor.orangeColor()
            markerLines.frame = CGRect(x: 200, y: 10, width: 15, height: 10)
            
            }, completion: nil)
        


    }


    
    
    func initAudioEngineGreen () {
        let fileURL = NSBundle.mainBundle().URLForResource("green", withExtension: "mp3")
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
    
    func initAudioEngine () {
        let fileURL = NSBundle.mainBundle().URLForResource("blueFlute", withExtension: "mp3")
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
    
    /**
    Uses an AVAudioPlayerNode to play an audio file.
    */
    
    
    
    func playerNodePlay() {
        if engine.running {
            playerNode.play()
        } else {
            var error: NSError?
            if !engine.startAndReturnError(&error) {
                println("error couldn't start engine")
                if let e = error {
                    println("error \(e.localizedDescription)")
                }
            } else {
                playerNode.play()
            }
        }
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
