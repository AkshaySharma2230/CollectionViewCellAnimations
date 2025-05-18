//
//  cellFlowLayout.swift
//  CrousalCollectionVwDemo
//
//  Created by Akshay Kumar on 15/05/25.
//

import Foundation
import UIKit


class ScalingCarouselFlowLayout: UICollectionViewFlowLayout {

    let zoomFactor: CGFloat = 0.25 // Controls the scale amount
    var collectionViewCenter: CGFloat {
        return (collectionView?.bounds.width ?? 0) / 2
    }

    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal

        let width = (collectionView?.bounds.width ?? 0) * 0.5
        itemSize = CGSize(width: width, height: 150) // default large size
        minimumLineSpacing = 0

        // Inset to keep first and last cell visible
        let inset = (collectionView?.bounds.width ?? 0 - width) / 2
        sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView,
              let attributesArray = super.layoutAttributesForElements(in: rect)?
                .map({ $0.copy() as! UICollectionViewLayoutAttributes }) else {
            return nil
        }

        let centerX = collectionView.contentOffset.x + collectionView.bounds.width / 2

        for attributes in attributesArray {
            let distance = attributes.center.x - centerX
            let normalized = distance / collectionView.bounds.width

            // Rotate up to 25 degrees (in radians)
            let maxAngle: CGFloat = .pi / 8 // ~22.5 degrees
            let angle = -normalized * maxAngle

            attributes.transform = CGAffineTransform(rotationAngle: angle)
            attributes.zIndex = Int(100 - abs(distance)) // Keep center cell above others
        }

        return attributesArray
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

