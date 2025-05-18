//
//  ColCVC.swift
//  CrousalCollectionVwDemo
//
//  Created by Akshay Kumar on 15/05/25.
//

import UIKit

class ColCVC: UICollectionViewCell {
    
    @IBOutlet weak var mainVw: UIView!
    @IBOutlet weak var img1: UIImageView!
    
    
    override func prepareForReuse() {
        mainVw.layer.cornerRadius = 8
        img1.layer.cornerRadius = 8
    }
    
}
