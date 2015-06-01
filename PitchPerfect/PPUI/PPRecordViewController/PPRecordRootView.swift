//
//  PPRecordRootView.swift
//  PitchPerfect
//
//  Created by Varvara Mironova on 13.05.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class PPRecordRootView: UIView {
    @IBOutlet weak var helpLabel            : UILabel!
    @IBOutlet weak var recordButton         : UIButton!
    
    var stopImage : UIImage!
    var recordImage : UIImage!
    
    deinit {
        recordImage = nil;
        stopImage = nil;
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stopImage = UIImage(named: "stop_on")
        recordImage = UIImage(named: "rec_on")
        helpLabel.text = "To record sound, please, tap on Rec button"
        activatePlayState(false)
    }
    
    func activatePlayState(playState: Bool) {
        var img = playState ? self.stopImage : self.recordImage
        var text = playState ? "To stop recording, please, tap on Stop button" : "To record sound, please, tap on Rec button"
        recordButton.setBackgroundImage(img, forState:UIControlState.Normal)
        helpLabel.text = text
    }
}
