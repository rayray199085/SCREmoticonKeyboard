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

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var toolbar: SCREmoticonToolbar!
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
        toolbar.delegate = self
        let bundle = Bundle(for: SCREmoticonKeyboard.self)
        guard let resourcesBundlePath = bundle.path(forResource: "Emoticons", ofType: "bundle"),
             let resourcesBundle = Bundle(path: resourcesBundlePath),
        let normalImagePath = resourcesBundle.path(forResource: "compose_keyboard_dot_normal@2x", ofType: "png"),
        let normalImage = UIImage(contentsOfFile: normalImagePath),
        let selectedImagePath = resourcesBundle.path(forResource: "compose_keyboard_dot_selected@2x", ofType: "png"),
        let selectedImage = UIImage(contentsOfFile: selectedImagePath) else{
            return
        }
        pageControl.setPageControlImages(normalImage: normalImage, selectedImage: selectedImage)
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
        guard let emoticon = emoticon else{
            return 
        }
        let currentIndexPath = collectionView.indexPathsForVisibleItems[0]
        if currentIndexPath.section == 0{
            return 
        }
        SCREmoticonManager.shared.addRecentEmoticon(emoticon: emoticon)
        collectionView.reloadSections(IndexSet(integersIn: 0..<1))
    }
}
extension SCREmoticonKeyboard: SCREmoticonToolbarDelegate{
    func toolbarDidSelectButton(toolbar: SCREmoticonToolbar, button: UIButton) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: button.tag), at: UICollectionView.ScrollPosition.left, animated: true)
        toolbar.selectedButtonIndex = button.tag
    }
}

extension SCREmoticonKeyboard{
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var center = scrollView.center
        center.x += scrollView.contentOffset.x
        
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        
        for indexPath in visibleIndexPaths{
            guard let cell = collectionView.cellForItem(at: indexPath) else{
                continue
            }
            if cell.frame.contains(center){
                toolbar.selectedButtonIndex = indexPath.section
                pageControl.numberOfPages = collectionView.numberOfItems(inSection: indexPath.section)
                pageControl.currentPage = indexPath.item
                break
            }
        }
    }
}
