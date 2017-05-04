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

    @IBOutlet weak var takenImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        takenImg.image = photoInfo?.image
        
    }



}
