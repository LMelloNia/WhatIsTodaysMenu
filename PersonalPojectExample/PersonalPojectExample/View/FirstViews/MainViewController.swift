//
//  MainViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/10.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var chooseListButton: UIButton!
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    
    let colors = [
        UIColor.black.cgColor,
        UIColor.white.cgColor
    ]
    
    func gradation(view: UIView) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.colors = colors
        gradient.type = .axial
        view.layer.addSublayer(gradient)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.shared.fetchFoods()
        
        //        setUpUI()
    }
//    let layout = UICollectionViewFlowLayout()
//    layout.minimumLineSpacing = 10
//    layout.minimumInteritemSpacing = 10
//    layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
//    layout.scrollDirection = .vertical
//
//    collectionView.collectionViewLayout = layout
//    collectionView.delegate = self
//    collectionView.dataSource = self
//    collectionView.register(UINib(nibName: kPhotoCell, bundle: nil), forCellWithReuseIdentifier: kPhotoCell)
//    }
    
    //    func setUpUI() {
    //        randomButton.clipsToBounds = true
    //        randomButton.layer.cornerRadius = 25
    //        chooseListButton.clipsToBounds = true
    //        chooseListButton.layer.cornerRadius = 25
    //    }
}



extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        //        return Category.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionViewCell
        
        let target = Category.allCases[indexPath.row].rawValue
        
        cell.nameLabel.text = target
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! CategoryHeaderCollectionReusableView
        
        header.categoryTitle.text = "카테고리를 고르세요"
        
        
        gradation(view: header.testView)
        return header
    }
}
