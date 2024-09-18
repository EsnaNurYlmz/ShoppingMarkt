//
//  CategoryDetailViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 18.09.2024.
//

import UIKit

class CategoryDetailViewController: UIViewController {

    @IBOutlet weak var CategoryDetailCollectionView: UICollectionView!
    var categoryDetailList = [CategoryDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CategoryDetailCollectionView.dataSource = self
        CategoryDetailCollectionView.delegate = self
        
    }
}
extension CategoryDetailViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryDetailList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryDetail = categoryDetailList[indexPath.row]
        let cell = CategoryDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "CatDetailCell", for: indexPath) as! CategoryDetailCollectionViewCell
        cell.categoryDetailName.text = categoryDetail.categoryDetailName
        
        if let url = URL(string: " /\(categoryDetail.categoryDetailImage!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.categoryDetailImage.image = UIImage(data: data!)
                }
            }
        }
        cell.categoryDetailImage.image = UIImage(named: categoryDetail.categoryDetailImage!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         self.performSegue(withIdentifier: "toProducts", sender: nil)
    }
    
}
