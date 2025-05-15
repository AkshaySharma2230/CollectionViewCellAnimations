//
//  CustomFlowLayout.swift
//  CrousalCollectionVwDemo
//
//  Created by Akshay Kumar on 15/05/25.
//

import Foundation
import UIKit


class CustomFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        minimumLineSpacing = 20
        
        let width = (collectionView?.bounds.width ?? 0) * 0.7
        let height: CGFloat = 180
        itemSize = CGSize(width: width, height: height)
        
        let inset = (collectionView!.bounds.width - width) / 2
        sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributesArray = super.layoutAttributesForElements(in: rect),
              let collectionView = self.collectionView else { return nil }

        let centerX = collectionView.contentOffset.x + collectionView.bounds.size.width / 2

        for attributes in attributesArray {
            let distance = abs(attributes.center.x - centerX)
            let scale = max(0.85, 1 - distance / collectionView.bounds.width)
            let yOffset: CGFloat = (scale == 1) ? -10 : 10 // lift center, push side cells

            attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
                .concatenating(CGAffineTransform(translationX: 0, y: yOffset))
            attributes.zIndex = Int(scale * 10)
        }

        return attributesArray
    }
}
