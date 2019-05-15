//
//  UIPageControl+extension.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 15/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

extension UIPageControl{
    func setPageControlImages(normalImage: UIImage, selectedImage:UIImage){
        setValue(normalImage, forKey: "_pageImage")
        setValue(selectedImage, forKey: "_currentPageImage")
    }
}
