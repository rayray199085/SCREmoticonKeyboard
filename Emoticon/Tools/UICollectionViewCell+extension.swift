//
//  UICollectionViewCell+extension.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 12/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

extension UICollectionViewCell{
    func improvePerformance(){
        layer.drawsAsynchronously = true
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
