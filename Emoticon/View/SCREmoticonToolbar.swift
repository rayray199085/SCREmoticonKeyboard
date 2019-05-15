//
//  SCEmoticonToolbar.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 11/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
protocol SCREmoticonToolbarDelegate: NSObjectProtocol {
    func toolbarDidSelectButton(toolbar: SCREmoticonToolbar, button: UIButton)
}
class SCREmoticonToolbar: UIView {
    weak var delegate: SCREmoticonToolbarDelegate?
    var selectedButtonIndex: Int = 0{
        didSet{
            for btn in subviews as! [UIButton]{
                btn.isSelected = false
            }
            (subviews[selectedButtonIndex] as! UIButton).isSelected = true
        }
    }
    
    override func awakeFromNib() {
        setupUI()
    }
    
    @objc private func clickToolbarButton(button: UIButton){
        delegate?.toolbarDidSelectButton(toolbar: self, button: button)
    }
}
private extension SCREmoticonToolbar{
    func setupUI() {
        
        guard let bundlePath = Bundle(for: SCREmoticonToolbar.self).path(forResource: "Emoticons", ofType: "bundle"),
            let bundle = Bundle(path: bundlePath),
            let leftBtnNormalImgPath = bundle.path(forResource: "compose_emotion_table_left_normal@2x", ofType: "png"),
            let leftBtnNormalImg = UIImage(contentsOfFile: leftBtnNormalImgPath),
            let leftBtnSelectedImgPath = bundle.path(forResource: "compose_emotion_table_left_selected@2x", ofType: "png"),
            let leftBtnSelectedImg = UIImage(contentsOfFile: leftBtnSelectedImgPath),
            
            let midBtnNormalImgPath = bundle.path(forResource: "compose_emotion_table_mid_normal@2x", ofType: "png"),
            let midBtnNormalImg = UIImage(contentsOfFile: midBtnNormalImgPath),
            let midBtnSelectedImgPath = bundle.path(forResource: "compose_emotion_table_mid_selected@2x", ofType: "png"),
            let midBtnSelectedImg = UIImage(contentsOfFile: midBtnSelectedImgPath),
            
            let rightBtnNormalImgPath = bundle.path(forResource: "compose_emotion_table_right_normal@2x", ofType: "png"),
            let rightBtnNormalImg = UIImage(contentsOfFile: rightBtnNormalImgPath),
            let rightBtnSelectedImgPath = bundle.path(forResource: "compose_emotion_table_right_selected@2x", ofType: "png"),
            let rightBtnSelectedImg = UIImage(contentsOfFile: rightBtnSelectedImgPath)else{
            return
        }
        let manager = SCREmoticonManager.shared
        for (index,v) in subviews.enumerated(){
            let btn = v as! UIButton
            btn.tag = index
            btn.addTarget(self, action: #selector(clickToolbarButton), for: UIControl.Event.touchUpInside)
            btn.setTitle(manager.emoticonPackages[index].emoticon_group_name, for: [])
            if btn == subviews.first{
                btn.setBackgroundImage(resizeImage(image: leftBtnNormalImg), for: [])
                btn.setBackgroundImage(resizeImage(image: leftBtnSelectedImg), for: UIControl.State.highlighted)
                btn.setBackgroundImage(resizeImage(image: leftBtnSelectedImg), for: UIControl.State.selected)
            }else if btn == subviews.last{
                btn.setBackgroundImage(resizeImage(image: rightBtnNormalImg), for: [])
                btn.setBackgroundImage(resizeImage(image: rightBtnSelectedImg), for: UIControl.State.highlighted)
                btn.setBackgroundImage(resizeImage(image: rightBtnSelectedImg), for: UIControl.State.selected)
            }else{
                btn.setBackgroundImage(resizeImage(image: midBtnNormalImg), for: [])
                btn.setBackgroundImage(resizeImage(image: midBtnSelectedImg), for: UIControl.State.highlighted)
                btn.setBackgroundImage(resizeImage(image: midBtnSelectedImg), for: UIControl.State.selected)
            }
        }
        (subviews[0] as! UIButton).isSelected = true
    }
    
    func resizeImage(image:UIImage)->UIImage{
        let size = image.size
        return image.resizableImage(withCapInsets:
            UIEdgeInsets(
                top: size.height * 0.5,
                left: size.width * 0.5,
                bottom: size.height * 0.5,
                right: size.width * 0.5))
    }
}
