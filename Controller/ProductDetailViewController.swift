//
//  ProductDetailViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 18.09.2024.
//

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var ProductDetailCollectionView: UICollectionView!
    var productDetailList = [ProductDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProductDetailCollectionView.dataSource = self
        ProductDetailCollectionView.delegate = self
        
    }
    

    

}
extension ProductDetailViewController : UICollectionViewDelegate , UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetailList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productDetail = productDetailList[indexPath.row]
        let cell = ProductDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "productDetailCell", for: indexPath) as! ProductDetailCollectionViewCell
        cell.productDetailName.text = productDetail.productDetailName
        cell.productDetailPrice.text = productDetail.productDetailPrice
        if let url = URL(string: " /\(productDetail.productDetailImage!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.productDetailImage.image = UIImage(data: data!)
                }
            }
        }
        cell.productDetailImage.image = UIImage(named: productDetail.productDetailImage!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toProduct", sender: nil)
    }
    
}
