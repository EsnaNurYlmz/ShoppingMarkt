//
//  FavoriteViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 16.09.2024.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    var favoriteList = [ProductDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
    }
    
}
extension FavoriteViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favoriteProducts = favoriteList[indexPath.row]
        let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCollectionViewCell
        cell.favoriteProductName.text = favoriteProducts.productDetailName
        cell.favoriteProductPrice.text = favoriteProducts.productDetailPrice
        if let url = URL(string: " /\(favoriteProducts.productDetailImage!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.favoriteImage.image = UIImage(data: data!)
                }
            }
        }
        cell.favoriteImage.image = UIImage(named: favoriteProducts.productDetailImage!)
        return cell
    }
    
}
