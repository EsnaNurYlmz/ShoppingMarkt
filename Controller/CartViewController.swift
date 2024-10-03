//
//  CartViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 16.09.2024.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var cartCollectionView: UICollectionView!
    var cartProductList = [ProductDetail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
       
    }
}
extension CartViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartProductList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let CartList = cartProductList[indexPath.row]
        let cell = cartCollectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath) as! CartCollectionViewCell
        cell.cartProductName.text = CartList.productDetailName
        cell.cartProductPrice.text = CartList.productDetailPrice
        if let url = URL(string: " /\(CartList.productDetailImage!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.cartImage.image = UIImage(data: data!)
                }
            }
        }
        cell.cartImage.image = UIImage(named: CartList.productDetailImage!)
        return cell
    }
}

