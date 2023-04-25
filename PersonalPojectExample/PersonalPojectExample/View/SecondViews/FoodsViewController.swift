//
//  FoodsViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/04/24.
//

import UIKit

class FoodsViewController: UIViewController {

    @IBOutlet weak var foodsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodsCollectionView.collectionViewLayout = createBasicListLayout()
        // Do any additional setup after loading the view.
    }
    

    func createBasicListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.33))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
//        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension FoodsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CoreDataManager.shared.foodEntitys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FoodsCollectionViewCell
        
        let target = CoreDataManager.shared.foodEntitys[indexPath.item]
        
//        cell.data = target
        cell.foodEntity = target
        cell.isAllRandom = target.isAllRandom
//        if let imageName = target.imageName.randomElement() {
//            cell.foodImageView.image = UIImage(named: imageName)!
//        }
        if let imageName = target.imageName?.components(separatedBy: ", ").randomElement() {
            cell.foodImageView.image = UIImage(named: imageName)!
        }
        
        cell.foodNameLabel.text = target.name
        
        // MARK: 둘중 하나는 수정
        cell.foodCategoryLabel.text = target.categories
//        cell.foodCategoryLabel.text = target.returnCategoryList()
        
        if target.isAllRandom { cell.isAllRandomButton.setTitle("❤️", for: .normal)
        } else {
            cell.isAllRandomButton.setTitle("💔", for: .normal)
        }
        return cell
    }
}
