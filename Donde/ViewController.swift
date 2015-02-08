//
//  ViewController.swift
//  Donde!
//
//  Created by  Apple on 2/5/15.
//  Copyright (c) 2015 TSosa. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController, AVAudioRecorderDelegate,AVAudioPlayerDelegate {

    var recorder:AVAudioRecorder = AVAudioRecorder()
    var player:AVAudioPlayer = AVAudioPlayer()
    
    var isDown:Bool = false
    
    var soundFileURL:NSURL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  //      redRecButton.enabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    /*@IBAction func record(sender: UIButton) {
    //This function will do the actual recording
        if player != nil && player.playing {
            player.stop()
        }
        
        if recorder == nil {
            println("recording. recorder nil")
            redRecButton.setTitle("Pause", forState:.Normal)
            recordWithPermission(true)
            return
        }
        
        if recorder != nil && recorder.recording {
            println("pausing")
            recorder.pause()
            recordButton.setTitle("Continue", forState:.Normal)
            
        } else {
            println("recording")
            recordButton.setTitle("Pause", forState:.Normal)
            //            recorder.record()
            recordWithPermission(false)
        }
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func buttonTouchesDidBegin(sender: AnyObject) {
        NSLog("Touches began")
        recorder.record()
    }
    
    @IBAction func buttonTouchesDidEnd(sender: AnyObject) {
        NSLog("Touches ended")
        recorder.stop()
        sleep(5)
        player.play()
    }
    

    @IBOutlet var redRecButton: UIButton!
    
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
        recorder = AVAudioRecorder(URL: soundFileURL!, settings: recordSettings, error: &error)
        if let e = error {
            println(e.localizedDescription)
        } else {
            recorder.delegate = self
            recorder.meteringEnabled = true
            recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        }
    }
    
    }



