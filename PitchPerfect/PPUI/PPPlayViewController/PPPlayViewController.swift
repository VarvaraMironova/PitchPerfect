//
//  PPPlayViewController.swift
//  PitchPerfect
//
//  Created by Varvara Mironova on 13.05.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit
import AVFoundation

class PPPlayViewController: UIViewController {
    private var _rootView   : PPPlayRootView?
    
    var playing             : Bool!
    
    var audioPlayer         : AVAudioPlayer!
    var audioEngine         : AVAudioEngine!
    
    var receivedAudio       : PPRecordedAudio!
    var audioFile           : AVAudioFile!
    
    var rootView            : PPPlayRootView {
        get {
            if (self.isViewLoaded() && view.isKindOfClass(PPPlayRootView)) {
                return (view as?PPPlayRootView)!
            }
            
            return _rootView!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var URL = receivedAudio.filePathURL as NSURL
        audioPlayer = AVAudioPlayer(contentsOfURL: URL, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: URL, error: nil)
        
        playing = false
    }

    @IBAction func onSnailButton(sender: AnyObject) {
        rootView.selectButton(sender as! UIButton)
        playAudioWithSpeed(0.5)
    }

    @IBAction func onHareButton(sender: AnyObject) {
        rootView.selectButton(sender as! UIButton)
        playAudioWithSpeed(1.5)
    }

    @IBAction func onChipmunkButton(sender: AnyObject) {
        rootView.selectButton(sender as! UIButton)
        playAudioWithPitch(1000)
    }
    
    @IBAction func onDartWaiderButton(sender: AnyObject) {
        rootView.selectButton(sender as! UIButton)
        playAudioWithPitch(-1000)
    }
    
    @IBAction func onStopButton(sender: AnyObject) {
        rootView.deselectButton()
        
        stopPlaying()
    }
    
    func playAudioWithSpeed(speed : Float) {
        stopPlaying()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithPitch(pitch : Float) {
        stopPlaying()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime:nil, completionHandler:nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    func stopPlaying() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
}
