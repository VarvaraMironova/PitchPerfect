//
//  PPRecordRootView.swift
//  PitchPerfect
//
//  Created by Varvara Mironova on 13.05.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class PPRecordRootView: UIView {
    @IBOutlet weak var helpLabel    : UILabel!
    @IBOutlet weak var recordButton : UIButton!
    
    let kVMStopRecordText  = "To stop press the Stop button"
    let kVMStartRecordText = "To record press the Rec button"
    
    func changeRecordingState(isRecording: Bool) {
        recordButton.isSelected = isRecording
        helpLabel.text = isRecording ? kVMStopRecordText : kVMStartRecordText
    }
}
