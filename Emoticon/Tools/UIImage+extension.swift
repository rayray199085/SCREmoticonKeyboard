//
//  UIImage+extension.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 12/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit


extension UIImage{
    /// modify an image size
    ///
    /// - Parameters:
    ///   - size: imageView.bounds.size
    ///   - backgroundColor: parent view color, default is white
    /// - Returns: an image with new size
    func modifyImageSize(size:CGSize?, backgroundColor: UIColor = UIColor.white) -> UIImage? {
        var size = size
        if size == nil{
            size = self.size
        }
        let rect = CGRect(origin: CGPoint(), size: size!)
        UIGraphicsBeginImageContextWithOptions(size!, true, 0)
        backgroundColor.setFill()
        UIRectFill(rect)
        draw(in: rect)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
