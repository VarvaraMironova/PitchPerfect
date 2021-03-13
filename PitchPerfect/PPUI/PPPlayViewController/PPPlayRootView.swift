//
//  PPPlayRootView.swift
//  PitchPerfect
//
//  Created by Varvara Mironova on 13.05.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class PPPlayRootView: UIView {
    @IBOutlet var stopButton         : UIButton!
    
    @IBOutlet var soundEffectButtons : [UIButton]!
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let layer = stopButton.layer
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.black.cgColor
        layer.masksToBounds = true
        layer.cornerRadius = stopButton.frame.size.width / 2.0
    }
    
    private weak var selectedButton : UIButton? {
        willSet(aNewValue) {
            if let aNewValue = aNewValue {
                //deselect oldValue
                selectedButton?.layer.borderWidth = 0.0
                
                //select aNewValue
                let borderColor = UIColor.systemRed
                aNewValue.layer.borderWidth = 3.0
                aNewValue.layer.borderColor = borderColor.cgColor
            }
        }
    }
    
    private func buttonForSoundEffect(soundEffect : Int) -> UIButton? {
        return soundEffectButtons.first(where: {
            return $0.tag == soundEffect
        })
    }
    
    func selectSoundEffect(soundEffectButton: UIButton) {
        selectedButton = soundEffectButton
    }
}
