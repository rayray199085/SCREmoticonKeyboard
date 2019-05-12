//
//  ViewController.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 8/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var keyboard = SCREmoticonKeyboard.emoticonKeyboard { [weak self] (emoticon) in
        self?.insertEmoticon(emoticon: emoticon)
    }
    private var emoticonText: String{
        guard let attrText = textView.attributedText else{
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
    @IBOutlet weak var textView: UITextView!
    @IBAction func clickSwitchButton(_ sender: Any) {
        textView.inputView = textView.inputView == nil ? keyboard : nil
        textView.reloadInputViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
    private func insertEmoticon(emoticon: SCREmoticon?){
        guard let emoticon = emoticon else{
            textView.deleteBackward()
            return
        }
        if let emoji = emoticon.emoji,
           let textRange = textView.selectedTextRange{
            textView.replace(textRange, withText: emoji)
            return
        }
        let imageText = emoticon.imageText(font: textView.font!)
        let attrTextM = NSMutableAttributedString(attributedString: textView.attributedText)
        attrTextM.replaceCharacters(in: textView.selectedRange, with: imageText)
        let range = textView.selectedRange
        textView.attributedText = attrTextM
        textView.selectedRange = NSRange(location: range.location + 1, length: 0)
        print(emoticonText)
    }
}

