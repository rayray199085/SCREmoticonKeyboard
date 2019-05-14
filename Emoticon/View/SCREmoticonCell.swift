//
//  SCEmoticonCell.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 11/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SCRHintView

protocol SCREmoticonCellDelegate: NSObjectProtocol {
    /// - Parameters:
    ///   - cell: collection view cell
    ///   - emoticon: nil means press delete button or return an emoticon model
    func cellDidSelectEmoticonKey(cell: SCREmoticonCell,emoticon: SCREmoticon?)
}
private let emoticonWidth: CGFloat = UIScreen.main.scale == 2 ? 32 : 48
class SCREmoticonCell: UICollectionViewCell {
    weak var delegate: SCREmoticonCellDelegate?
    
    private lazy var hintView = SCRHintView()
    /// Maximun number is 20
    var emoticons : [SCREmoticon]?{
        didSet{
            for v in contentView.subviews{
                v.isHidden = true
            }
            for (index,emoticon) in (emoticons ?? []).enumerated(){
                let btn = contentView.subviews[index] as! UIButton
                let width = round((btn.bounds.width))
                let height = round((btn.bounds.height))
                btn.setImage(emoticon.image?.modifyImageSize(size: CGSize(width: width, height: height)), for: [])
                
                let emoji = emoticon.emoji
                btn.setTitle(emoji, for: [])
                let fontSize = emoji?.getTextFontWithLabelHeight(width: btn.bounds.height) ?? 32
                btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
                btn.isHidden = false
            }
            
            let bundle = Bundle(for: SCREmoticonCell.self)
            guard let resourceBundlePath = bundle.path(forResource: "Emoticons", ofType: "bundle"),
                  let resourceBundle = Bundle(path: resourceBundlePath),
                  let deleteBtnNormalImagePath = resourceBundle.path(forResource: "compose_emotion_delete@2x", ofType: "png"),let deleteBtnHighlightedImagePath =   resourceBundle.path(forResource: "compose_emotion_delete_highlighted@2x", ofType: "png") else{
                    return
            }
            let deleteBtn = contentView.subviews.last as! UIButton
            deleteBtn.setImage(UIImage(contentsOfFile: deleteBtnNormalImagePath), for: [])
            deleteBtn.setImage(UIImage(contentsOfFile: deleteBtnHighlightedImagePath), for: UIControl.State.highlighted)
            deleteBtn.isHidden = false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        improvePerformance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func clickEmoticonButton(button: UIButton){
        var emoticon: SCREmoticon?
        if button.tag < emoticons?.count ?? 0{
            emoticon = emoticons?[button.tag]
        }
        delegate?.cellDidSelectEmoticonKey(cell: self, emoticon: emoticon)
    }
    
    @objc private func longPressGestureObserver(recognizer: UILongPressGestureRecognizer){
        let location = recognizer.location(in: self)
        guard let btn = getButtonWithLocation(location: location),
            let emoticon = emoticons?[btn.tag] else{
            return
        }
        hintView.icon = SCRHintIcon(image: emoticon.image, text: emoticon.emoji)
        guard let button = hintView.showWithLongPress(parentView: self, pressView: btn, recognizer: recognizer) as? UIButton else{
            return
        }
        clickEmoticonButton(button: button)
    }
    private func getButtonWithLocation(location: CGPoint)->UIButton?{
        for btn in contentView.subviews as! [UIButton]{
            if !btn.isHidden && btn.frame.contains(location) && btn != contentView.subviews.last{
                return btn
            }
            hintView.isHidden = true
        }
        return nil
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        guard let win = newWindow else{
            return
        }
        win.addSubview(hintView)
    }
}
private extension SCREmoticonCell{
    func setupUI(){
        let numberOfEmoticonPerPage: Int = 21
        let numberOfRow:CGFloat = 3
        let numberOfColumn:CGFloat = 7
        let width: CGFloat = emoticonWidth
        let horizontalMargin = (bounds.width - width * numberOfColumn) / 8
        let verticalMargin = (bounds.height - width * numberOfRow) / 4
        
        for index in 0..<numberOfEmoticonPerPage{
            let x: Int = Int((width + horizontalMargin) * CGFloat(index % Int(numberOfColumn)) + horizontalMargin)
            let y: Int = Int((width + verticalMargin) * CGFloat(index / Int(numberOfColumn)) + verticalMargin)
            let button = UIButton(frame: CGRect(x: CGFloat(x), y: CGFloat(y), width: width, height: width))
            button.tag = index
            button.addTarget(self, action: #selector(clickEmoticonButton), for: UIControl.Event.touchUpInside)
            contentView.addSubview(button)
        }
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureObserver))
        longPress.minimumPressDuration = 0.5
        addGestureRecognizer(longPress)
    }
    
}
