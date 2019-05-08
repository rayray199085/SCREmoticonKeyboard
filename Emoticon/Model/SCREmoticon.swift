//
//  SCREmoticon.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 8/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import YYModel

public class SCREmoticon: NSObject {
    @objc var chs: String?
    @objc var png: String?
    @objc var type = false
    @objc var code: String?
    @objc var directory: String?
    @objc var image: UIImage?{
        if type{
            return nil
        }
        guard let resourcePath = Bundle(for: SCREmoticonManager.self).path(forResource: "Emoticons", ofType: "bundle"),
              let imageBundle = Bundle(path: resourcePath),
              let imageName = png,
              let directory = directory as NSString? else{
            return nil
        }
        return UIImage(named: directory.appendingPathComponent(imageName), in: imageBundle, compatibleWith: nil)
    }
    
    func imageText(font: UIFont)->NSAttributedString{
        guard let image = image else{
            return NSAttributedString(string: "")
        }
        let attachment = NSTextAttachment()
        let height = font.lineHeight
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: -height * 0.2, width: height, height: height)
        return NSAttributedString(attachment: attachment)
    }
    
    override public var description: String{
        return yy_modelDescription()
    }
}
