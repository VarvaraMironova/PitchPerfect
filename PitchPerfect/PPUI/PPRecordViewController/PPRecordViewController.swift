//
//  PPRecordViewController.swift
//  PitchPerfect
//
//  Created by Varvara Mironova on 12.05.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit
import AVFoundation

class PPRecordViewController: UIViewController,
                              AVAudioRecorderDelegate
{
    
    var recording     : Bool = false {
        willSet(aNewValue) {
            if aNewValue != recording {
                rootView?.changeRecordingState(isRecording: aNewValue)
            }
        }
    }
    
    var audioRecorder : AVAudioRecorder!
    var recordedAudio : PPRecordedAudio?
    
    weak private var rootView: PPRecordRootView? {
        return viewIfLoaded as? PPRecordRootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAudioRecorder()
    }
    
    override func prepare(for segue : UIStoryboardSegue,
                          sender    : Any?) {
        if segue.identifier == "stopRecording" {
            if let playSoundVC = segue.destination as? PPPlayViewController,
               let data = sender as? PPRecordedAudio
            {
                playSoundVC.receivedAudio = data
            }
        }
    }
    
    @IBAction func onRecordButton(sender: UIButton) {
        recording = !recording;
        let session = AVAudioSession.sharedInstance()
        
        if (true == recording) {
            do {
                try session.setCategory(.playAndRecord)
                audioRecorder.prepareToRecord()
                audioRecorder.record()
            } catch {
                print(error)
            }
        } else {
            audioRecorder.stop()
            do {
                try session.setActive(false, options: [])
            } catch {
                print(error)
            }
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder         : AVAudioRecorder,
                                         successfully flag  : Bool)
    {
        if (flag) {
            let URL = recorder.url
            let title = recorder.url.lastPathComponent
            recordedAudio = PPRecordedAudio(filePathURL : URL,
                                            title       : title)
            performSegue(withIdentifier : "stopRecording",
                         sender         : recordedAudio)
        } else {
            //show allert
            print("Error!")
        }
    }
    
    func setAudioRecorder() {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        
        let recordingName = formatter.string(from: currentDateTime)
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask,
                                                           true)
        if let dirPath = dirPaths.first {
            let filePath = String(format: "%@/%@", dirPath, recordingName)
            let fileURL = URL(fileURLWithPath: filePath)
            
            do {
                try audioRecorder = AVAudioRecorder(url      : fileURL,
                                                    settings : [:])
                
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true;
            } catch {
                print(error)
            }
        }
    }
}

