//
//  RoteroViewController.swift
//  CrousalCollectionVwDemo
//
//  Created by Akshay Kumar on 15/05/25.
//

import UIKit

class RoteroViewController: UIViewController {

    @IBOutlet weak var CollVw: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollVw.delegate = self
        CollVw.dataSource = self
        
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    
    private func setupCollectionView() {
        CollVw.showsHorizontalScrollIndicator = false
        CollVw.decelerationRate = .fast
        let layout = RotaryCarouselFlowLayout()
        CollVw.collectionViewLayout = layout
        
    }
}


extension RoteroViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoteroCVC", for: indexPath) as? RoteroCVC else {
            return UICollectionViewCell()
        }
        
        cell.contentView.layer.cornerRadius = 8
        
        return cell
    }
    
}



class RotaryCarouselFlowLayout: UICollectionViewFlowLayout {

    let activeDistance: CGFloat = 200//200
    let zoomFactor: CGFloat = 0//0.25//0.25
    let angleFactor: CGFloat = 0//.pi / 6 // 30 degrees rotation

    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        minimumLineSpacing = 16
        itemSize = CGSize(width: 273, height: 180)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView,
              let attributes = super.layoutAttributesForElements(in: rect)?.map({ $0.copy() as! UICollectionViewLayoutAttributes })
        else { return nil }

        let centerX = collectionView.contentOffset.x + (collectionView.bounds.width / 2)
        
        let maxScaleX: CGFloat = 1.0
        let maxScaleY: CGFloat = 1.0
        let minScaleX: CGFloat = 265/*212*/ / 273 // ~0.78
        let minScaleY: CGFloat = 160/*140*/ / 180 // ~0.78
        
        let minYOffset: CGFloat = 2
        let maxYOffset: CGFloat = 30

        for attr in attributes {
            let distance = abs(centerX - attr.center.x)
            let normalized = min(distance / activeDistance, 1)

            let scaleX = minScaleX + (maxScaleX - minScaleX) * (1 - normalized)
            let scaleY = minScaleY + (maxScaleY - minScaleY) * (1 - normalized)
            let yOffset = maxYOffset * normalized + minYOffset * (1 - normalized)

            attr.transform = CGAffineTransform(translationX: 0, y: yOffset).scaledBy(x: scaleX, y: scaleY)
            attr.zIndex = Int((1 - normalized) * 10)
        }

        return attributes
    }


    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }

        let targetRect = CGRect(origin: proposedContentOffset, size: collectionView.bounds.size)

        guard let attributes = super.layoutAttributesForElements(in: targetRect) else { return proposedContentOffset }

        let centerX = proposedContentOffset.x + collectionView.bounds.width / 2

        var closest: UICollectionViewLayoutAttributes?
        for attr in attributes {
            if closest == nil || abs(attr.center.x - centerX) < abs(closest!.center.x - centerX) {
                closest = attr
            }
        }

        guard let closestAttr = closest else { return proposedContentOffset }

        let offsetX = closestAttr.center.x - collectionView.bounds.width / 2
        return CGPoint(x: offsetX, y: proposedContentOffset.y)
    }
}
