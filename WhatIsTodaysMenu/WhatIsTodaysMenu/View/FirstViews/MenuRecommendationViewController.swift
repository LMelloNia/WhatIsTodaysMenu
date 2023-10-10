//
//  MenuRecommendationViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/13.
//

import UIKit

class MenuRecommendationViewController: UIViewController {
    @IBOutlet weak var randomMenuButton: UIButton!
    @IBOutlet weak var randomFoodsCollectionView: UICollectionView!

    var category: String?
    var target: Food?
    var randomFoods: [Food] = []
    var foodListList: [FoodRecommendationList] = []
    var foodRecommendationListEntity: FoodRecommendationListEntity?
    var currentIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        randomMenuButton.clipsToBounds = true
        randomMenuButton.layer.cornerRadius = 10

        // MARK: 옵저버 두번째 추가한 부분
        NotificationCenter.default.addObserver(forName: .list, object: nil, queue: .main) { noti in
            if let foodList = noti.userInfo?["name"] as? FoodRecommendationList {
                self.foodListList.append(foodList)
            }
        }

        randomFoodsCollectionView.collectionViewLayout = createBasicListLayout()
    }
    
    // MARK: 추천한 메뉴를 음식추천목록에 추가
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recommendToFoodListList" {
            if let vc = segue.destination.children.first as? FoodListViewController {
                vc.foodRecommendationListList = self.foodListList
                vc.target = target
            }
        }
    }

    func createBasicListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    // MARK: 랜덤 버튼을 눌렀을때 룰렛이 돌아가듯이 설정되어있는 것들중에서 랜덤으로 추천
    @IBAction func pressedRandomMenuButton(_ sender: Any) {
        randomFoodsCollectionView.scrollToItem(at: IndexPath(item: Int.random(in: 500 - (randomFoods.count * 3)...500 + (randomFoods.count * 3)), section: 0), at: .bottom, animated: true)
    }
}



extension MenuRecommendationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomFoodsCollectionViewCell", for: indexPath) as! RandomFoodsCollectionViewCell
        let realIndex = indexPath.row % randomFoods.count
        let target = randomFoods[realIndex]
        if let imageName = target.imageName.randomElement() {
            cell.randomMenuImageView.image = UIImage(named: imageName)
        }
        cell.nameLabel.text = target.name

        return cell
    }
}
