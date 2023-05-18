//
//  FoodChooseViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/05/16.
//

import UIKit

class FoodChooseViewController: UIViewController {

    var list = [Food]()
    var filteredFoods = foods
    var alreadyHaveFoods = [Food]()

    @IBOutlet weak var foodListCollectionView: UICollectionView!

    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, layoutEnv in
            switch section {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                      heightDimension: .fractionalHeight(1))

                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalHeight(0.285))

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

    override func viewDidLoad() {
        super.viewDidLoad()

        foods.forEach {
            $0.isChecked = false
        }
        foodListCollectionView.collectionViewLayout = createLayout()
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }


    @IBAction func completeButtonTapped(_ sender: Any) {
//        if let indexPath = tableView.indexPathsForSelectedRows {
//            indexPath.forEach {
//                list.append(filteredFoods[$0.row])
//            }
//        }
        filteredFoods.forEach {
            if $0.isChecked {
                list.append($0)
            }
        }
        NotificationCenter.default.post(name: .select, object: nil, userInfo: ["name": list])

        dismiss(animated: true)
    }

    func actionSheet(complition: @escaping (String?) -> ()) {
        let alertController = UIAlertController(title: nil, message: "이 음식은 이미 추가되어 있습니다.", preferredStyle: .alert)

        let addAgain = UIAlertAction(title: "다시 추가", style: .default) { action in complition(action.title) }

        let skip = UIAlertAction(title: "건너뛰기", style: .default) { action in complition(action.title) }

        alertController.addAction(addAgain)
        alertController.addAction(skip)

        present(alertController, animated: true)
    }
}



extension FoodChooseViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(filteredFoods.count)
        return filteredFoods.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodChooseCollectionViewCell", for: indexPath) as! FoodChooseCollectionViewCell

        if !filteredFoods.isEmpty {
            let target = filteredFoods[indexPath.item]

            if let imageName = target.imageName.first {
                cell.foodImageView.image = UIImage(named: imageName)!
            }
//            cell.foodImageView.image = target.imageName.first

//            if list.contains(where: { Food in
//                Food.name == filteredFoods[indexPath.row].name
//            })
            cell.foodNameLabel.text = target.name
            if target.isChecked {
//                cell.foodNameLabel.text = "\(target.name) 선택됨"
//                cell.foodSelectButton.setImage(chechImage, for: .highlighted)
                cell.contentView.layer.borderWidth = 3
            } else {

//                cell.foodSelectButton.setImage(plusImage, for: .highlighted)
                cell.contentView.layer.borderWidth = 0
            }
            // MARK: 둘중 하나는 수정
//            cell.foodCategoryLabel.text = target.returnCategoryList()
            cell.foodCategoryLabel.text = target.categoryList
        }

        return cell

    }
}



extension FoodChooseViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let target = filteredFoods[indexPath.item]

//        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
//        cell.contentView.layer.borderWidth = 3
//        cell.layer.borderColor = UIColor.black.cgColor

        // MARK: 중복선택시 다시추가할지 말지
        if let a = alreadyHaveFoods.first(where: { food in
            food.name == target.name
        }) {
            actionSheet { title in
                if let title, title == "건너뛰기" {
                    return
                } else if title == "다시 추가" {
                    target.isChecked = true
                    collectionView.reloadItems(at: [indexPath])
                    return
                }
            }
        } else {
            target.isChecked.toggle()
            collectionView.reloadItems(at: [indexPath])
        }
    }
}



extension FoodChooseViewController: UISearchBarDelegate {
    func filter(with keyword: String) {
        if keyword.count > 0 {
            filteredFoods = foods.filter { $0.name.contains(keyword) }
        } else {
            filteredFoods = foods
        }

        foodListCollectionView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter(with: searchText)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = nil
    }
}

