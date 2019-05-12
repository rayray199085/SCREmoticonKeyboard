//
//  String+extension.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 12/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

extension String{
    //    NSDictionary *dict = @{NSFontAttributeName:font};
    //    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    func getTextFontWithLabelHeight(width: CGFloat)->CGFloat{
        var maxFont: CGFloat = 1
        var currentHeight: CGFloat = 0
        while currentHeight < width{
            let dict = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: maxFont)]
            let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
            currentHeight = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dict, context: nil).height
            maxFont += 1
        }
        return maxFont - 1
    }
}

extension String{
    /// get emoji from hex code string
    ///
    /// - Returns: string if find or nil
    func getEmojiFromHexInt32CodeString()->String?{
        let scanner = Scanner(string: self)
        var result : UInt32 = 0
        scanner.scanHexInt32(&result)
        guard let res = Unicode.Scalar(result) else {
            return nil
        }
        return String(Character(res))
    }
}

