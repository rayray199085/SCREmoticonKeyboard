//
//  ViewController.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 8/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var keyboard = SCEmoticonKeyboard.emoticonKeyboard()
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
        
    }
    @IBAction func clickSwitchButton(_ sender: Any) {
        textView.inputView = textView.inputView == nil ? keyboard : nil
        textView.reloadInputViews()
    }
    
}

