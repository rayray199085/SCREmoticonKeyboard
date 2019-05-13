//
//  UITextView+extension.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 13/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

extension UITextView{
    /// convert attributed string to string for sending to the server
    public var emoticonText: String{
        guard let attrText = attributedText else{
            return ""
        }
        var textString: String = String()
        attrText.enumerateAttributes(in: NSRange(location: 0, length: attrText.length), options: []) { (dict, range, _) in
            if let attachment = dict[NSAttributedString.Key.attachment] as? SCRTextAttachment{
                textString += attachment.chs ?? ""
            }else{
                textString += attrText.attributedSubstring(from: range).string
            }
        }
        return textString
    }
    public func insertEmoticon(emoticon: SCREmoticon?){
        guard let emoticon = emoticon else{
            deleteBackward()
            return
        }
        if let emoji = emoticon.emoji,
            let textRange = selectedTextRange{
            replace(textRange, withText: emoji)
            return
        }
        let imageText = emoticon.imageText(font: font!)
        let attrTextM = NSMutableAttributedString(attributedString: attributedText)
        attrTextM.replaceCharacters(in: selectedRange, with: imageText)
        let range = selectedRange
        attributedText = attrTextM
        selectedRange = NSRange(location: range.location + 1, length: 0)
        delegate?.textViewDidChange?(self)
    }
}
