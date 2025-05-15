//
//  ViewController.swift
//  CrousalCollectionVwDemo
//
//  Created by Akshay Kumar on 15/05/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colVw: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colVw.delegate = self
        colVw.dataSource = self
        
        let layout = ScalingCarouselFlowLayout()
        colVw.collectionViewLayout = layout
        colVw.decelerationRate = .fast
        colVw.clipsToBounds = false
        // Do any additional setup after loading the view.
    }


    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = colVw.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
        let estimatedIndex = scrollView.contentOffset.x / cellWidth
        let index = round(estimatedIndex)

        targetContentOffset.pointee = CGPoint(x: index * cellWidth - (colVw.bounds.width - layout.itemSize.width) / 2, y: 0)
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColCVC", for: indexPath) as? ColCVC else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
}
