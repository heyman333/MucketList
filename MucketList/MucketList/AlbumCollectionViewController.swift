//
//  AlbumCollectionViewController.swift
//  MucketList
//
//  Created by HanYoungsoo on 2017. 5. 8..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import UIKit

class AlbumCollectionViewController: UIViewController {
    
    var photoInfoArr: Array<PhotoInfo>!
    
    @IBOutlet weak var photoAlbumCollectionView: UICollectionView!
    @IBOutlet weak var photoAlbumCollectionViewLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        print(photoAlbumCollectionView.frame.size.width)
        let itemSize = (photoAlbumCollectionView.frame.size.width - 10) / 2.0
        photoAlbumCollectionViewLayout.itemSize = CGSize(width: itemSize, height: itemSize)
    }
}

extension AlbumCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoInfoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionCell", for: indexPath) as! AlbumCollectionViewCell
        
        if let cellImg = photoInfoArr[indexPath.row].image, let date = photoInfoArr[indexPath.row].date {
            
            cell.takenImgView.image = UIImage(data: cellImg)
            cell.takenDate.text = date.description(with: Locale.current)
            print(date.description(with: Locale.current))
            
        } else {
            
            cell.takenImgView.image = UIImage(named:"Steve")
            cell.takenDate.text = "로딩실패"
            
        }
    
        return cell
    }
}
