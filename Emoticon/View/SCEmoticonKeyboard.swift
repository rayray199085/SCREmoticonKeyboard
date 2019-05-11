//
//  SCEmoticonKeyboard.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 11/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
private let reuseIdentifier = "cell_id"
public class SCEmoticonKeyboard: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var toolbar: UIView!
    class func emoticonKeyboard(keyboardSize: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 260))-> SCEmoticonKeyboard{
        let nib = UINib(nibName: "SCEmoticonKeyboard", bundle: Bundle(for: SCEmoticonKeyboard.self))
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCEmoticonKeyboard
        v.frame = keyboardSize
        return v
    }
    
    public override func awakeFromNib() {
        collectionView.register(UINib(nibName: "SCEmoticonCell", bundle: Bundle(for: SCEmoticonKeyboard.self)), forCellWithReuseIdentifier: reuseIdentifier)
    }
}
extension SCEmoticonKeyboard: UICollectionViewDelegate, UICollectionViewDataSource{
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SCREmoticonManager.shared.emoticonPackages.count
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SCEmoticonCell
        cell.label.text = "\(indexPath.section) \(indexPath.item)"
        return cell
    }
}
