//
//  SCEmoticonKeyboard.swift
//  SCREmoticonKeyboard
//
//  Created by Stephen Cao on 11/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
private let reuseIdentifier = "cell_id"
public class SCREmoticonKeyboard: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var toolbar: UIView!
    private var selectedEmoticon:((_ emoticon: SCREmoticon?)->())?
    
    public class func emoticonKeyboard(keyboardSize: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 260), selectedEmoticon:@escaping (_ emoticon: SCREmoticon?)->())-> SCREmoticonKeyboard{
        let nib = UINib(nibName: "SCREmoticonKeyboard", bundle: Bundle(for: SCREmoticonKeyboard.self))
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCREmoticonKeyboard
        v.frame = keyboardSize
        v.selectedEmoticon = selectedEmoticon
        return v
    }
    
    public override func awakeFromNib() {
        collectionView.register(SCREmoticonCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}
extension SCREmoticonKeyboard: UICollectionViewDelegate, UICollectionViewDataSource{
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SCREmoticonManager.shared.emoticonPackages.count
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return SCREmoticonManager.shared.emoticonPackages[section].numberOfPages
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SCREmoticonCell
        cell.emoticons = SCREmoticonManager.shared.emoticonPackages[indexPath.section].getEmoticon(page: indexPath.item)
        cell.delegate = self
        return cell
    }
}

extension SCREmoticonKeyboard: SCREmoticonCellDelegate{
    func cellDidSelectEmoticonKey(cell: SCREmoticonCell, emoticon: SCREmoticon?) {
        selectedEmoticon?(emoticon)
    }
}
