//
//  SCEmoticonLayout.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 12/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCREmoticonLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else{
            return
        }
        scrollDirection = UICollectionView.ScrollDirection.horizontal
        itemSize = collectionView.bounds.size
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
}
