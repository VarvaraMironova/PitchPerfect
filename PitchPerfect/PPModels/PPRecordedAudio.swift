//
//  PPRecordedAudio.swift
//  PitchPerfect
//
//  Created by Varvara Mironova on 22.05.15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import Foundation

class PPRecordedAudio {
    
    var filePathURL : URL!
    var title       : String!
    
    init(filePathURL: URL, title: String) {
        self.filePathURL = filePathURL
        self.title = title
    }
}
