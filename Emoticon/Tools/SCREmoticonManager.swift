//
//  SCREmoticonManager.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 8/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import MJExtension

public class SCREmoticonManager{
    public static let shared = SCREmoticonManager()
    lazy var emoticonPackages = [SCREmoticonPackage]()
    private init(){
        loadPackage()
    }
}
extension SCREmoticonManager{
     public func searchEmoticon(text: String)-> SCREmoticon?{
        for package in emoticonPackages{
            let result = package.emoticonList.filter { (emoticon) -> Bool in
                return emoticon.chs == text
            }
            if result.count > 0{
                return result[0]
            }
        }
        return nil
    }
    
    public func getEmoticonString(text: String, font: UIFont)->NSAttributedString{
        let textM = NSMutableAttributedString(string: text)
        let pattern = "\\[.*?\\]"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else{
            return textM
        }
        let results = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
        for res in results.reversed(){
            let subString = (text as NSString).substring(with: res.range(at: 0))
            guard let emoticon = SCREmoticonManager.shared.searchEmoticon(text: subString) else{
                continue
            }
            textM.replaceCharacters(in: res.range(at: 0), with: emoticon.imageText(font: font))
        }
        textM.addAttributes(
            [NSAttributedString.Key.font : font,
             NSAttributedString.Key.foregroundColor: UIColor.darkGray],
            range: NSRange(location: 0, length: textM.length))
        return textM
    }
    
    /// Add recent used emoticon
    ///
    /// - Parameter emoticon: emoticon
    public func addRecentEmoticon(emoticon: SCREmoticon){
        emoticon.usedCount += 1
        if !emoticonPackages[0].emoticonList.contains(emoticon){
            emoticonPackages[0].emoticonList.append(emoticon)
        }
        emoticonPackages[0].emoticonList.sort { (em1, em2) -> Bool in
            return em1.usedCount > em2.usedCount
        }
        if emoticonPackages[0].emoticonList.count > 20{
            emoticonPackages[0].emoticonList.removeSubrange(
                20..<emoticonPackages[0].emoticonList.count)
        }
    }
}

private extension SCREmoticonManager{
    func loadPackage(){
        let bundle = Bundle(for: SCREmoticonManager.self)
        guard let path = bundle.path(forResource: "Emoticons", ofType: "bundle", inDirectory: nil),
            let emoticonBundle = Bundle(path: path),
            let listPath = emoticonBundle.path(forResource: "emoticons", ofType: "plist", inDirectory: nil),
            let array = NSArray(contentsOf: URL(fileURLWithPath: listPath)) as? [[String: String]],
            let packages = SCREmoticonPackage.mj_objectArray(withKeyValuesArray: array) as? [SCREmoticonPackage] else{
                return
        }
        emoticonPackages += packages
    }
}
