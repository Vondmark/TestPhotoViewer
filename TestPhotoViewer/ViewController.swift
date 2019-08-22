//
//  ViewController.swift
//  TestPhotoViewer
//
//  Created by Mark on 8/20/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
import Kingfisher
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    fileprivate var longPressGesture: UILongPressGestureRecognizer!
    @IBOutlet weak var colletionView: UICollectionView!
    
    
    let photos = ["ponchik","rain","green","tree","ponchik","rain","green","tree","33"]
    
    
    var URLImages: [String] = [
    
        "https://cdn.pixabay.com/photo/2019/05/31/14/22/sea-4242303_1280.jpg",
        "https://cdn.pixabay.com/photo/2019/08/14/13/46/condor-4405821_1280.jpg",
        "https://cdn.pixabay.com/photo/2017/05/09/23/02/dog-2299482_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/08/27/10/11/radio-cassette-3634616_1280.png",
        "https://cdn.pixabay.com/photo/2019/08/13/20/41/dom-4404207__480.jpg",
        "https://cdn.pixabay.com/photo/2015/05/29/19/17/study-789631__480.jpg",
        "https://cdn.pixabay.com/photo/2019/08/18/21/06/rottweiler-4415054__480.jpg",
        
    ]
    var urlImage = ""
    var passUrl = ""

        override func viewDidLoad() {
        super.viewDidLoad()

            
            colletionView.dataSource = self
            colletionView.delegate = self
            
            
            longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
            colletionView.addGestureRecognizer(longPressGesture)
            
            let layout = self.colletionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.sectionInset = UIEdgeInsets(top: 10,left: 5,bottom: 0,right: 5)
            layout.minimumInteritemSpacing = 5
            layout.itemSize = CGSize(width:
                (self.colletionView.frame.size.width - 20)/2, height: self.colletionView.frame.size.height/3)
            
        
    }
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer){
        switch (gesture.state) {
        case .began:
            guard let selectedIndexPath = colletionView.indexPathForItem(at: gesture.location(in: colletionView)) else {
                break
            }
            colletionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            colletionView.updateInteractiveMovementTargetPosition((gesture.location(in: gesture.view!)))
        case .ended:
            colletionView.endInteractiveMovement()
        default:
            colletionView.cancelInteractiveMovement()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return URLImages.count
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = URLImages.remove(at: sourceIndexPath.item)
        URLImages.insert(item, at: destinationIndexPath.item)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        urlImage = URLImages[indexPath.item] as String
        
        
        cell.imgvpHeader.kf.indicatorType = .activity
        cell.imgvpHeader.kf.setImage(with: URL(string: urlImage), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        print(urlImage)
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    
    
    
    
    // Action when click on cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        
        passUrl = URLImages[indexPath.item] as String
        performSegue(withIdentifier: "photo", sender: self)
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.layer.borderWidth = 2
        print("Selected")
        print(indexPath)
        print(passUrl)
        
        
    }
    //unselected cell
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 0.5
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PhotosViewController
        destinationVC.photoUrlVar = passUrl
        print(destinationVC.photoUrlVar)
    }
    

    
}

