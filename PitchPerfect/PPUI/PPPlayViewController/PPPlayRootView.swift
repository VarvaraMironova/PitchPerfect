//
//  PPPlayRootView.swift
//  PitchPerfect
//
//  Created by Varvara Mironova on 13.05.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class PPPlayRootView: UIView {
    @IBOutlet var stopButton        : UIButton!
    @IBOutlet var snailButton       : UIButton!
    @IBOutlet var hareButton        : UIButton!
    @IBOutlet var chipmunkButton    : UIButton!
    @IBOutlet var dartWaiderButton  : UIButton!
    
    weak var selectedButton         : UIButton!
    
    func selectButton(button: UIButton) {
        if (nil != selectedButton) {
            deselectButton()
        }
        
        button.layer.borderWidth = 2.0
        
        var myColor : UIColor = UIColor(red: 0.5, green: 0.5, blue:0, alpha: 1.0)
        button.layer.borderColor = (myColor).CGColor
        
        selectedButton = button
    }
    
    func deselectButton() {
        if (nil != selectedButton) {
            selectedButton.layer.borderWidth = 0.0
            selectedButton = nil;
        }
    }
}
