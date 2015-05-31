//
//  PPRecordRootView.swift
//  PitchPerfect
//
//  Created by Varvara Mironova on 13.05.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class PPRecordRootView: UIView {
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var microphoneImageView: UIImageView!
    
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
        activatePlayState(false)
    }
    
    func activatePlayState(playState: Bool) {
        var img = playState ? self.stopImage : self.recordImage;
        recordButton.setBackgroundImage(img, forState:UIControlState.Normal);
        
        if (playState) {
            UIView.animateWithDuration(0.2, animations: {
                
            })
        }
    }
}
