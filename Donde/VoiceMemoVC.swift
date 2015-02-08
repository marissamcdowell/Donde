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

class VoiceMemoVC:UIViewController, AVAudioRecorderDelegate,AVAudioPlayerDelegate {
    
    // UI components
    
    @IBOutlet weak var holdAndRecordLabel: UILabel!
    @IBOutlet var redRecButton: UIButton!
    @IBOutlet weak var tryAgainBtn: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    var recorder:AVAudioRecorder = AVAudioRecorder()
    var player:AVAudioPlayer = AVAudioPlayer()
    
    var isDown:Bool = false
    
    var soundFileURL:NSURL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redRecButton.enabled = true
        // Do any additional setup after loading the view, typically from a nib.
        
        tryAgainBtn.layer.cornerRadius = 10
        nextButton.layer.cornerRadius = 10
//        
//        recorder.delegate = self
//        recorder.prepareToRecord()
        setupRecorder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buttonTouchesDidBegin(sender: AnyObject) {
        NSLog("Touches began")
        var defaults = NSUserDefaults.standardUserDefaults()
        if( defaults.boolForKey("micAccessAllowed") ){
            recorder.record()
        } else {
            var alert = UIAlertView(title: "No Mic Access", message: "Go to Settings to give mic permission", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        
    }
    
    @IBAction func buttonTouchesDidEnd(sender: AnyObject) {
        NSLog("Touches ended")
        var audioInst = AVAudioSession.sharedInstance()
//        if( audioInst.inputAvailable ){
            recorder.stop()
            sleep(5)
            player.play()
            tryAgainBtn.hidden = false
            nextButton.hidden = false
            holdAndRecordLabel.hidden = true
//        } else {
//            var alert = UIAlertView(title: "No mic", message: "", delegate: self, cancelButtonTitle: "OK")
//            alert.show()
//        }
        
    }
    
    func setupRecorder() {
        var format = NSDateFormatter()
        format.dateFormat="yyyy-MM-dd-HH-mm-ss"
        var currentFileName = "recording-\(format.stringFromDate(NSDate())).m4a"
        println(currentFileName)
        
        var dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var docsDir: AnyObject = dirPaths[0]
        var soundFilePath = docsDir.stringByAppendingPathComponent(currentFileName)
        let newURL = NSURL(fileURLWithPath: soundFilePath)
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
        recorder = AVAudioRecorder(URL: newURL, settings: recordSettings, error: &error)
        if let e = error {
            println(e.localizedDescription)
        } else {
            recorder.delegate = self
            recorder.meteringEnabled = true
            recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        }
    }
    
    @IBAction func tryAgainClicked(sender: UIButton) {
        holdAndRecordLabel.hidden = false
        nextButton.hidden = true
        tryAgainBtn.hidden = true
    }
}