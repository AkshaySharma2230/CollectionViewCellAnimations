//
//  NewAnimationViewController.swift
//  CrousalCollectionVwDemo
//
//  Created by Akshay Kumar on 18/05/25.
//

import UIKit

class NewAnimationViewController: UIViewController {

    @IBOutlet weak var colVw: UICollectionView!
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colVw.delegate = self
        colVw.dataSource = self
        // Do any additional setup after loading the view.
    }
}


//MARK: UICollectionview Delegate & DataSource Methods
extension NewAnimationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewAnimationCVC", for: indexPath) as? NewAnimationCVC else {
            return UICollectionViewCell()
        }
        return cell
    }
}
