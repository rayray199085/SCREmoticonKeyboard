//
//  SCRHintIcon.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 14/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

public class SCRHintIcon: NSObject {
    var image: UIImage?
    var text: String?
    
    public init(image: UIImage? = nil, text: String? = nil){
        self.image = image
        self.text = text
    }
}
