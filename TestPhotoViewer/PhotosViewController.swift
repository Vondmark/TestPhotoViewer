//
//  PhotosViewController.swift
//  TestPhotoViewer
//
//  Created by Mark on 8/20/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
import Kingfisher

class PhotosViewController: UIViewController {

    @IBOutlet weak var imgvHeader: UIImageView!
    var photoUrlVar:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()


        imgvHeader.kf.indicatorType = .activity
        imgvHeader.kf.setImage(with: URL(string: photoUrlVar), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
