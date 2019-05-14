//
//  SCRHintView.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 14/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

public class SCRHintView: UIImageView {
    private var hintButtonCenterY: CGFloat = 0
    private var previousIcon: SCRHintIcon?
    public var icon: SCRHintIcon?{
        didSet{
            if icon?.image != nil && icon?.image == previousIcon?.image{
                return
            }
            else if icon?.text != nil && icon?.text == previousIcon?.text{
                return
            }
            previousIcon = icon
            hintButton.setImage(icon?.image, for: [])
            hintButton.setTitle(icon?.text, for: [])
        
            hintButton.addPopVerticalAnimation(
                fromValue: hintButtonCenterY * 2,
                toValue: hintButtonCenterY,
                springBounciness: 15,
                springSpeed: 12, delay: 0)
        }
    }
    private lazy var hintButton = UIButton()
    
    public init() {
        let bundle = Bundle(for: SCRHintView.self)
        guard let resourcesBundlePath = bundle.path(forResource: "resources", ofType: "bundle"),
            let resourcesBundle = Bundle(path: resourcesBundlePath),
            let magnifierImagePath = resourcesBundle.path(forResource: "magnifier@2x", ofType: "png"),
            let magnifierImage = UIImage(contentsOfFile: magnifierImagePath) else{
            super.init(frame: CGRect())
            return
        }
        let image = magnifierImage
        super.init(image: image)
        layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        
        let imageWidth = image.size.width
        hintButton.frame = CGRect(x: 0, y: 0, width: imageWidth * 0.5, height: imageWidth * 0.5)
        hintButton.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        hintButton.center = center
        hintButtonCenterY = hintButton.center.y
        hintButton.titleLabel?.font = UIFont.systemFont(ofSize: "".getTextFontWithLabelHeight(width: imageWidth * 0.5))
        addSubview(hintButton)
        isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension SCRHintView{
    
    /// show hind view
    ///
    /// - Parameters:
    ///   - parentView: parentView which holds press view
    ///   - pressView: the view which is being pressed
    ///   - recognizer: UILongPressGestureRecognizer
    /// - Returns: if long press gesture with ended state, return the pressing view
    public func showWithLongPress(parentView: UIView, pressView: UIView?, recognizer: UILongPressGestureRecognizer)->UIView?{
        guard let pressView = pressView else{
            return nil
        }
        switch recognizer.state {
            case .began, .changed:
                isHidden = false
                let center = parentView.convert(CGPoint(x: pressView.center.x, y: pressView.frame.minY), to: parentView.window)
               self.center = center
            case .ended:
                isHidden = true
                return pressView
            case .cancelled,.failed:
                isHidden = true
            default:
                break
        }
        return nil
    }
}
