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
        UIColor.clear.cgColor,
        UIColor.gray.cgColor
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

    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, layoutEnv in
            switch section {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                                      heightDimension: .fractionalHeight(1.0))

                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalHeight(0.15))

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 5)

                section.orthogonalScrollingBehavior = .groupPaging

                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                            heightDimension: .estimated(40)),
                                                                         elementKind: UICollectionView.elementKindSectionHeader,
                                                                         alignment: .topLeading,
                                                                         absoluteOffset: CGPoint(x: 0, y: 0))

                section.boundarySupplementaryItems = [header]
                return section
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1.0))

                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 10)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.42),
                                                       heightDimension: .fractionalHeight(0.24))

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 5)

                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                            heightDimension: .estimated(40)),
                                                                         elementKind: UICollectionView.elementKindSectionHeader,
                                                                         alignment: .topLeading,
                                                                         absoluteOffset: CGPoint(x: 0, y: 0))

                section.boundarySupplementaryItems = [header]
                return section
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1.0))

                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 10)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.42),
                                                       heightDimension: .fractionalHeight(0.24))

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 5)

                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                            heightDimension: .estimated(40)),
                                                                         elementKind: UICollectionView.elementKindSectionHeader,
                                                                         alignment: .topLeading,
                                                                         absoluteOffset: CGPoint(x: 0, y: 0))

                section.boundarySupplementaryItems = [header]
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCollectionView.collectionViewLayout = createLayout()
        CoreDataManager.shared.fetchFoods()
        CoreDataManager.shared.fetchfavorite()
        CoreDataManager.shared.RecommenedFoodArray()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.shared.fetchfavorite()
        mainCollectionView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? CategoryCollectionViewCell {
            if let vc = segue.destination as? MenuRecommendationViewController {
                guard let category = cell.nameLabel.text else { return }
                vc.category = category
            }
        }
    }
}



extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return Category.allCases.count + 1
        } else if section == 1 {
            return CoreDataManager.shared.favoriteFoods.count
        } else {
            return CoreDataManager.shared.recommendedFoods.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell

            if indexPath.item == 0 {
                cell.categoryImageView.image = UIImage(systemName: "questionmark")
                cell.nameLabel.text = "랜덤"
                return cell
            } else {
                let target = Category.allCases[indexPath.item - 1].rawValue

                cell.categoryImageView.image = UIImage(named: target)
                cell.nameLabel.text = target

                return cell
            }
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteFoodCollectionViewCell", for: indexPath) as! FavoriteFoodCollectionViewCell

            let target = CoreDataManager.shared.favoriteFoods[indexPath.item]

            cell.foodEntity = target
            cell.favorite = target.favorite
            if let imageName = target.imageName?.components(separatedBy: ", ").randomElement() {
                cell.foodImageView.image = UIImage(named: imageName)!
            }

            cell.foodNameLabel.text = target.name

            cell.foodCategoryLabel.text = target.categories
            if target.favorite { cell.isAllRandomButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                cell.isAllRandomButton.setImage(UIImage(systemName: "star"), for: .normal)
            }

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteFoodCollectionViewCell", for: indexPath) as! FavoriteFoodCollectionViewCell

            let target = CoreDataManager.shared.recommendedFoods[indexPath.item]

            cell.foodEntity = target
            cell.favorite = target.favorite
            if let imageName = target.imageName?.components(separatedBy: ", ").randomElement() {
                cell.foodImageView.image = UIImage(named: imageName)!
            }

            cell.foodNameLabel.text = target.name

            // MARK: 둘중 하나는 수정
            cell.foodCategoryLabel.text = target.categories
            if target.favorite { cell.isAllRandomButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                cell.isAllRandomButton.setImage(UIImage(systemName: "star"), for: .normal)
            }

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! CategoryHeaderCollectionReusableView

        if indexPath.section == 0 {
            header.categoryTitle.text = "카테고리를 고르세요"
        } else if indexPath.section == 1 {
            header.categoryTitle.text = "즐겨찾는 음식"
        } else {
            header.categoryTitle.text = "이런 메뉴들은 어떠세요?"
        }
        return header
    }
}



extension MainViewController: UICollectionViewDelegateFlowLayout {
}
