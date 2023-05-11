//
//  FoodsViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/04/24.
//

import UIKit

class FoodsViewController: UIViewController {

    @IBOutlet weak var foodsCollectionView: UICollectionView!

    var hashTagItem: [FoodEntity]?

    override func viewDidLoad() {
        super.viewDidLoad()
        //        CoreDataManager.shared.fetchFoods()
        hashTagItem = CoreDataManager.shared.foodEntitys
        foodsCollectionView.collectionViewLayout = createLayout()
    }


    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, layoutEnv in
            switch section {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(50),
                                                      heightDimension: .fractionalHeight(1))

                let item = NSCollectionLayoutItem(layoutSize: itemSize)

//                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)

                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(50),
                                                       heightDimension: .fractionalHeight(0.05))

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])

//                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)

                let section = NSCollectionLayoutSection(group: group)

                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

                section.orthogonalScrollingBehavior = .continuous

                return section
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                      heightDimension: .fractionalHeight(1))

                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalHeight(0.32))

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

                return section
            default:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                                      heightDimension: .fractionalHeight(1.0))

                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalHeight(0.15))

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                section.orthogonalScrollingBehavior = .groupPaging

                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                            heightDimension: .estimated(150)),
                                                                         elementKind: UICollectionView.elementKindSectionHeader,
                                                                         alignment: .topLeading,
                                                                         absoluteOffset: CGPoint(x: 0, y: 50))

                section.boundarySupplementaryItems = [header]
                return section
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        hashTagItem = CoreDataManager.shared.foodEntitys
        foodsCollectionView.reloadData()
    }
}




extension FoodsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return Category.allCases.count
        } else {
//            return CoreDataManager.shared.foodEntitys.count
            return hashTagItem!.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HashTagCollectionViewCell", for: indexPath) as! HashTagCollectionViewCell

            cell.hashTagLabel.text = "# \(Category.allCases[indexPath.item].rawValue)     "

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FoodsCollectionViewCell

//            let target = CoreDataManager.shared.foodEntitys[indexPath.item]

            let target = hashTagItem![indexPath.item]

            cell.foodEntity = target
            cell.isAllRandom = target.isAllRandom
            if let imageName = target.imageName?.components(separatedBy: ", ").randomElement() {
                cell.foodImageView.image = UIImage(named: imageName)!
            }

            cell.foodNameLabel.text = target.name

            cell.foodCategoryLabel.text = target.categories

            if target.isAllRandom { cell.isAllRandomButton.setTitle("❤️", for: .normal)
            } else {
                cell.isAllRandomButton.setTitle("💔", for: .normal)
            }
            return cell
        }
    }
}

extension FoodsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let name = Category.allCases[indexPath.item].rawValue
            hashTagItem = CoreDataManager.shared.foodEntitys.filter { FoodEntity in
                FoodEntity.categories?.contains(name) ?? false
            }
            foodsCollectionView.reloadSections(IndexSet(integer: 1))
        }
    }
}

extension FoodsViewController: UICollectionViewDelegateFlowLayout {

}
