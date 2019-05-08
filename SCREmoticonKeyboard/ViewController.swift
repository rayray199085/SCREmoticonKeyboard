//
//  ViewController.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 8/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let text = "我[爱你]啊[笑哈哈]!"
        label.attributedText = SCREmoticonManager.shared.getEmoticonString(text: text, font: label.font)
    }
}

