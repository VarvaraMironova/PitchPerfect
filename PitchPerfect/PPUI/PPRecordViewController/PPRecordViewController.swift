//
//  PPRecordViewController.swift
//  PitchPerfect
//
//  Created by Varvara Mironova on 12.05.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit
import AVFoundation

class PPRecordViewController: UIViewController, AVAudioRecorderDelegate {
    private var _rootView: PPRecordRootView?
    
    var recording     : Bool!
    var audioRecorder : AVAudioRecorder!
    var recordedAudio : PPRecordedAudio!
    
    var rootView      : PPRecordRootView {
        get {
            if (self.isViewLoaded() && view.isKindOfClass(PPRecordRootView)) {
                return (view as?PPRecordRootView)!
            }
            
            return _rootView!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recording = false
        
        setAudioRecorder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundVC:PPPlayViewController = segue.destinationViewController as! PPPlayViewController
            let data:PPRecordedAudio = sender as! PPRecordedAudio
            playSoundVC.receivedAudio = data
        }
    }
    
    @IBAction func onRecordButton(sender: UIButton) {
        recording = !recording;
        rootView.activatePlayState(recording)
        var session = AVAudioSession.sharedInstance()
        
        if (true == recording) {
            session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        } else {
            audioRecorder.stop()
            session.setActive(false, error: nil)
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag) {
            var URL = recorder.url
            var title = recorder.url.lastPathComponent
            recordedAudio = PPRecordedAudio(filePathURL:URL!, title:title!)

            performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            //show allert
            println("Error!")
        }
    }
    
    func setAudioRecorder() {
        let currentDateTime = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        
        var recordingName = formatter.stringFromDate(currentDateTime)
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let filePath = NSURL.fileURLWithPathComponents([dirPath, recordingName])
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true;
    }
}

