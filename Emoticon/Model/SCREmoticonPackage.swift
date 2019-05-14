//
//  SCREmoticonPackage.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 8/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import MJExtension

public class SCREmoticonPackage: NSObject {
    @objc public var emoticon_group_name: String?
    @objc public var emoticon_group_path: String?{
        didSet{
            let bundle = Bundle(for: SCREmoticonManager.self)
            guard let directoryName = emoticon_group_path,
                  let path = bundle.path(forResource: "Emoticons", ofType: "bundle", inDirectory: nil),
                  let emoticonBundle = Bundle(path: path),
                  let plistPath = emoticonBundle.path(forResource: directoryName, ofType: ".plist", inDirectory: directoryName),
                  let plistDict = NSDictionary(contentsOf: URL(fileURLWithPath: plistPath)),
                  let array = plistDict["emoticon_group_emoticons"] as? [[String: Any]],
                  let emoticons = SCREmoticon.mj_objectArray(withKeyValuesArray: array) as? [SCREmoticon] else{
                return
            }
            for emoticon in emoticons{
                emoticon.directory = directoryName
            }
            emoticonList += emoticons
            
        }
    }
    @objc public lazy var emoticonList: [SCREmoticon] = [SCREmoticon]()
    
    @objc public var numberOfPages: Int{
        return (emoticonList.count - 1) / 20 + 1
    }
    
    func getEmoticon(page: Int)->[SCREmoticon]{
        let remaining = emoticonList.count - page * 20 >= 20 ? 20 : emoticonList.count - page * 20
        return (emoticonList as NSArray).subarray(with: NSRange(location: page * 20, length: remaining)) as! [SCREmoticon]
    }
}
