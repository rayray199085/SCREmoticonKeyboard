//
//  SCREmoticonPackage.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 8/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import YYModel

class SCREmoticonPackage: NSObject {
    @objc var emoticon_group_name: String?
    @objc var emoticon_group_path: String?{
        didSet{
            let bundle = Bundle(for: SCREmoticonManager.self)
            guard let directoryName = emoticon_group_path,
                  let path = bundle.path(forResource: "Emoticons", ofType: "bundle", inDirectory: nil),
                  let emoticonBundle = Bundle(path: path),
                  let plistPath = emoticonBundle.path(forResource: directoryName, ofType: ".plist", inDirectory: directoryName),
                  let plistDict = NSDictionary(contentsOf: URL(fileURLWithPath: plistPath)),
                  let array = plistDict["emoticon_group_emoticons"] as? [[String: Any]],
                  let emoticons = NSArray.yy_modelArray(with: SCREmoticon.self, json: array) as? [SCREmoticon] else{
                return
            }
            for emoticon in emoticons{
                emoticon.directory = directoryName
            }
            emoticonList += emoticons
            
        }
    }
    @objc lazy var emoticonList: [SCREmoticon] = [SCREmoticon]()
    
    override var description: String{
        return yy_modelDescription()
    }
}
