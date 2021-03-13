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
    
    var playing             : Bool = false
    
    var audioPlayer         : AVAudioPlayer?
    var audioEngine         : AVAudioEngine?
    var audioFile           : AVAudioFile?
    var audioPlayerNode     : AVAudioPlayerNode?
    
    var receivedAudio       : PPRecordedAudio?
    
    weak private var rootView: PPPlayRootView? {
        return viewIfLoaded as? PPPlayRootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Making the sound louder
        do {
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
        } catch {
            print(error)
        }
        
        //setup audioPlayer
        if let receivedAudio = receivedAudio,
           let URL = receivedAudio.filePathURL
        {
            do {
                let data = try Data(contentsOf: URL)
                audioPlayer = try AVAudioPlayer(data: data, fileTypeHint: nil)
                audioPlayer?.enableRate = true
                audioPlayer?.volume = 1.0
                audioFile = try AVAudioFile(forWriting  : URL,
                                            settings    : [:])
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func onSoundEffectButton(sender: UIButton) {
        switch sender.tag {
        case 1:
            //onSnailButton
            playAudioWithSpeed(speed: 0.5)
            break
            
        case 2:
            //onHareButton
            playAudioWithSpeed(speed: 1.5)
            break
            
        case 3:
            //onChipmunkButton
            playAudioWithPitch(pitch: 1000)
            break
            
        case 4:
            //onDartWaiderButton
            playAudioWithPitch(pitch: -1000)
            break
            
        default:
            break
        }
        
        rootView?.selectSoundEffect(soundEffectButton: sender)
        
    }
    
    @IBAction func onStopButton(sender: UIButton) {
        stopPlaying()
    }
    
    func playAudioWithSpeed(speed : Float) {
        if let audioPlayer = audioPlayer {
            stopPlaying()
            audioPlayer.rate = speed
            audioPlayer.currentTime = 0.0
            audioPlayer.play()
        }
    }
    
    func playAudioWithPitch(pitch : Float) {
        if let audioFile = audioFile
        {
            stopPlaying()
            
            audioPlayerNode = AVAudioPlayerNode()
            audioEngine = AVAudioEngine()
            audioEngine!.attach(audioPlayerNode!)
            
            let changePitchEffect = AVAudioUnitTimePitch()
            changePitchEffect.pitch = pitch
            audioEngine!.attach(changePitchEffect)
            
            audioEngine!.connect(audioPlayerNode!,
                                to      : changePitchEffect,
                                format  : nil)
            audioEngine!.connect(changePitchEffect,
                                to      : audioEngine!.mainMixerNode,
                                format  : nil)
            
            audioPlayerNode!.scheduleFile(audioFile,
                                          at : nil)
            
            do {
                try audioEngine!.start()
                
                audioPlayerNode!.play()
            } catch {
                print(error)
            }
        }
    }
    
    private func stopPlaying() {
        audioPlayer?.stop()
        
        if let audioEngine = audioEngine
        {
            audioEngine.stop()
            audioEngine.reset()
        }
    }
    
    private func pausePlaying() {
        if let audioPlayer = audioPlayer,
           let audioEngine = audioEngine
        {
            audioPlayer.pause()
            audioEngine.pause()
        }
    }
    
    private func resumePlaying() {
        audioPlayer?.play()
        
        if let audioEngine = audioEngine
        {
            do {
                try audioEngine.start()
                
                audioPlayerNode!.play()
            } catch {
                print(error)
            }
        }
    }
}
