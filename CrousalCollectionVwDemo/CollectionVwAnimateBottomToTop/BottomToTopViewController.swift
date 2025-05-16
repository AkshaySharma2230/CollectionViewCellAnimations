//
//  BottomToTopViewController.swift
//  CrousalCollectionVwDemo
//
//  Created by Akshay Kumar on 16/05/25.
//

import UIKit

class BottomToTopViewController: UIViewController {
    
    @IBOutlet weak var colVw: UICollectionView!
    
    var animatedIndexPaths: Set<IndexPath> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colVw.delegate = self
        colVw.dataSource = self
        // Do any additional setup after loading the view.
    }
}


//MARK: UICollectionview Delegate & DataSource Method
extension BottomToTopViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Set cell size: width = view.width / 3, height = 100
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3 - 10
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomToTopCVC", for: indexPath) as? BottomToTopCVC else {
            return UICollectionViewCell()
        }
     
        cell.contentView.layer.cornerRadius = 8
        
        return cell
    }
    
    // Animate cells from bottom to top
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Check if this indexPath has already been animated
        if animatedIndexPaths.contains(indexPath) {
            return
        }

        // Mark this indexPath as animated
        animatedIndexPaths.insert(indexPath)

        // Animate from bottom
        cell.transform = CGAffineTransform(translationX: 0, y: collectionView.bounds.height)
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.4,
            delay: 0.03 * Double(indexPath.row),
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.2,
            options: [.curveEaseOut],
            animations: {
                cell.transform = .identity
                cell.alpha = 1
            },
            completion: nil
        )
    }

}
