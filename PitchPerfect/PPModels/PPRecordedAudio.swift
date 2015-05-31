//
//  PPRecordedAudio.swift
//  PitchPerfect
//
//  Created by Varvara Mironova on 22.05.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import Foundation

class PPRecordedAudio : NSObject {
    
    var filePathURL : NSURL!
    var title       : NSString!
    
    init(filePathURL:NSURL, title:NSString) {
        self.filePathURL = filePathURL
        self.title = title
    }
}
