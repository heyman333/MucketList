//
//  ContentsViewController.swift
//  MucketList
//
//  Created by HanYoungsoo on 2017. 5. 5..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import UIKit

class ContentsViewController: UIViewController {
    
    var photoInfo: PhotoInfo?
    @IBOutlet weak var latitudeLB: UILabel!
    @IBOutlet weak var longitudeLB: UILabel!
    @IBOutlet weak var creationDateLB: UILabel!
    @IBOutlet weak var takenImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let photoInfo = photoInfo{
            takenImg.image = UIImage(data: photoInfo.image!)
            creationDateLB.text = photoInfo.date?.description(with: Locale.current)
            
            if photoInfo.latitude != 0.0, photoInfo.longitude != 0.0 {
                latitudeLB.text = String(photoInfo.latitude)
                longitudeLB.text = String(photoInfo.longitude)
            } else {
                latitudeLB.text = "위도없음"
                longitudeLB.text = "경도없음"
            }
        }
    }
}
