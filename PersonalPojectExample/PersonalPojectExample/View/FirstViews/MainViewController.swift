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
    @IBOutlet weak var gradationView: UIView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    
    let colors = [
        UIColor.green.cgColor,
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
    
    func createBasicListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                              heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.15))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
//        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPaging
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                            heightDimension: .estimated(150)),
                                                                         elementKind: UICollectionView.elementKindSectionHeader,
                                                                         alignment: .topLeading,
                                                                         absoluteOffset: CGPoint(x: 0, y: 50))
                
        section.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCollectionView.collectionViewLayout = createBasicListLayout()
        gradation(view: gradationView)
        CoreDataManager.shared.fetchFoods()
//        mainCollectionView.layer.backgroundColor = UIColor.black.cgColor
        //        setUpUI()
    }
    
//    func setUp() {
//        gradationView.translatesAutoresizingMaskIntoConstraints = false
//
//        self.view.addSubview(gradationView)
//
//        gradationView.topAnchor.constraint(equalTo: mainCollectionView.topAnchor).isActive = true
//        gradationView.bottomAnchor.constraint(equalTo: mainCollectionView.bottomAnchor).isActive = true
//        gradationView.leadingAnchor.constraint(equalTo: mainCollectionView.leadingAnchor).isActive = true
//        gradationView.trailingAnchor.constraint(equalTo: mainCollectionView.trailingAnchor).isActive = true
//    }
    
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
                return Category.allCases.count
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
        
        
        return header
    }
}



extension MainViewController: UICollectionViewDelegateFlowLayout {
}
