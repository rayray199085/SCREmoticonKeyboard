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
        self?.textView.insertEmoticon(emoticon: emoticon)
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
}

