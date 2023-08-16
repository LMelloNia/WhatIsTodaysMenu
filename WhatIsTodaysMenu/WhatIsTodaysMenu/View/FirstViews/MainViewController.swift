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
        UIColor(red: 246/255, green: 248/255, blue: 200/255, alpha: 0.5),
        UIColor(red: 200/255, green: 251/255, blue: 254/255, alpha: 0.5),
        UIColor(red: 200/255, green: 259/255, blue: 200/255, alpha: 0.5),
        UIColor(red: 200/255, green: 200/255, blue: 250/255, alpha: 0.5)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCollectionView.collectionViewLayout = createLayout()
        CoreDataManager.shared.fetchFoods()
        CoreDataManager.shared.fetchfavorite()
        CoreDataManager.shared.recommenedFoodArray()
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
                // MARK: 카테고리가 랜덤이 아니라면 카테고리로 인스턴스 생성, 카테고리가 랜덤이라면 전체 음식을 대상으로 인스턴스 생성
                guard category != "랜덤" else {
                    CoreDataManager.shared.fetchIsAllRandom()
                    vc.randomFoods = CoreDataManager.shared.isAllRandomFoods.map {
                        Food(image: ($0.imageName?.components(separatedBy: ", "))!,
                             name: $0.name!, country: [Country.chinese], isAllRandom: $0.favorite) }
                    return
                }
                vc.category = category
                CoreDataManager.shared.fetchCategory(category: category)
                // MARK: 랜덤으로 돌릴 음식들의 목록을 인스턴스로 만들기
                vc.randomFoods = CoreDataManager.shared.isAllRandomFoods.map {
                    Food(image: ($0.imageName?.components(separatedBy: ", "))!,
                         name: $0.name!, country: [Country.chinese], isAllRandom: $0.favorite) }
            }
        }
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
                                                       heightDimension: .fractionalHeight(0.16))

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 15, trailing: 5)

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

                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 15, trailing: 5)

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
                cell.colorBackgroundView.backgroundColor = .lightGray
                return cell
            } else {
                let target = Category.allCases[indexPath.item - 1].rawValue

                cell.categoryImageView.image = UIImage(named: target)
                cell.nameLabel.text = target
                cell.colorBackgroundView.backgroundColor = colors[indexPath.item % colors.count]
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
