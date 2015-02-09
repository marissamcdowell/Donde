//
//  VoiceMemoVC.swift
//  Donde
//
//  Created by Marissa McDowell on 2/8/15.
//
//


import UIKit
import AVFoundation
import Foundation
import AudioToolbox

class VoiceMemoVC:UIViewController, AVAudioRecorderDelegate,AVAudioPlayerDelegate {
    
    // UI components
    
    @IBOutlet weak var holdAndRecordLabel: UILabel!
    @IBOutlet var redRecButton: UIButton!
    @IBOutlet weak var tryAgainBtn: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var session = AVAudioSession.sharedInstance()
    
    var recorder:AVAudioRecorder?
    var player:AVAudioPlayer?
    
    var isDown:Bool = false
    
    var soundFileURL:NSURL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redRecButton.enabled = true
        // Do any additional setup after loading the view, typically from a nib.
        
        tryAgainBtn.layer.cornerRadius = 10
        nextButton.layer.cornerRadius = 10

        setupRecorder()
        
        // headphone override
        var headphones = false
        var outputs = AVAudioSession.sharedInstance().currentRoute.outputs
        for output in outputs{
            if output.portType == "Headphones"{
                println("Headphones detected")
                headphones = true
            }
        }
        var session = AVAudioSession.sharedInstance()
        if headphones{
            session?.overrideOutputAudioPort(AVAudioSessionPortOverride.None, error: nil)
        }else{
           session?.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buttonTouchesDidBegin(sender: AnyObject) {
        NSLog("Touches began")
        var defaults = NSUserDefaults.standardUserDefaults()
        recordWithPermission(defaults.boolForKey("micAccessAllowed"))
    }
    
    @IBAction func buttonTouchesDidEnd(sender: AnyObject) {
        NSLog("Touches ended")
        var audioInst = AVAudioSession.sharedInstance()
        stop()
        sleep(3)
        play()
        tryAgainBtn.hidden = false
        nextButton.hidden = false
        holdAndRecordLabel.hidden = true
        redRecButton.enabled = false
    }
    
    func stop() {
        println("stop")
        recorder?.stop()
        
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setActive(false, error: &error) {
            println("could not make session inactive")
            if let e = error {
                println(e.localizedDescription)
                return
            }
        }
        recorder = nil
    }
    
    func setupRecorder() {
        var format = NSDateFormatter()
        format.dateFormat="yyyy-MM-dd-HH-mm-ss"
        var currentFileName = "recording-\(format.stringFromDate(NSDate())).m4a"
        println(currentFileName)
        
        var dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var docsDir: AnyObject = dirPaths[0]
        var soundFilePath = docsDir.stringByAppendingPathComponent(currentFileName)
        soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        let filemanager = NSFileManager.defaultManager()
        if filemanager.fileExistsAtPath(soundFilePath) {
            // probably won't happen. want to do something about it?
            println("sound exists")
        }
        
        var recordSettings = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,//Potential Error Here
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        var error: NSError?
        recorder = AVAudioRecorder(URL: soundFileURL, settings: recordSettings, error: &error)
        
        if let e = error {
            println(e.localizedDescription)
        } else {
            recorder?.delegate = self
            recorder?.meteringEnabled = true
            recorder?.prepareToRecord() // creates/overwrites the file at soundFileURL
        }
    }
    
    @IBAction func tryAgainClicked(sender: UIButton) {
        holdAndRecordLabel.hidden = false
        nextButton.hidden = true
        tryAgainBtn.hidden = true
        redRecButton.enabled = true
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        print("just played")
        println(flag)
    }
    
    /* if an error occurs while decoding it will be reported to the delegate. */
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!){
        print("audioplayerdecodeerror")
        println(error)
    }

    func recordWithPermission(setup:Bool) {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        // ios 8 and later
        if (session.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    println("Permission to record granted")
                    self.setSessionPlayAndRecord()
                    if setup {
                        self.setupRecorder()
                    }
                    self.recorder?.record()
                    
                } else {
                    println("Permission to record not granted")
                }
            })
        } else {
            println("requestRecordPermission unrecognized")
        }
    }

    func setSessionPlayback() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setCategory(AVAudioSessionCategoryPlayback, error:&error) {
            println("could not set session category")
            if let e = error {
                println(e.localizedDescription)
            }
        }
        if !session.setActive(true, error: &error) {
            println("could not make session active")
            if let e = error {
                println(e.localizedDescription)
            }
        }
    }

    func setSessionPlayAndRecord() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setCategory(AVAudioSessionCategoryPlayAndRecord, error:&error) {
            println("could not set session category")
            if let e = error {
                println(e.localizedDescription)
            }
        }
        if !session.setActive(true, error: &error) {
            println("could not make session active")
            if let e = error {
                println(e.localizedDescription)
            }
        }
    }
    
    func play() {
        println("playing")
        var error: NSError?
        // recorder might be nil
        // self.player = AVAudioPlayer(contentsOfURL: recorder.url, error: &error)
        
        //self.player = AVAudioPlayer(contentsOfURL: soundFileURL!, error: &error)
        
        var soundData = NSData(contentsOfURL: soundFileURL!)
        self.player = AVAudioPlayer(data: soundData, error: &error)
        
        println( soundData )
        
        if self.player == nil {
            if let e = error {
                println(e.localizedDescription)
            }
            
        }
        self.player?.delegate = self
        self.player?.prepareToPlay()
        self.player?.volume = 1.0
        self.player?.play()
    }
}