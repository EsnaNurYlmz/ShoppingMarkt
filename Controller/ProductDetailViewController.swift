//
//  ProductDetailViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 18.09.2024.
//

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var ProductDetailCollectionView: UICollectionView!
    var viewModel = ProductDetailViewModel()
    var categoryProduct: Products?
    var selectedCategoryId: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProductDetailCollectionView.dataSource = self
        ProductDetailCollectionView.delegate = self
        
        bindViewModel()
        
        if let category_id = selectedCategoryId {
            viewModel.fetchProductDetail(productId: category_id)
        }
    }
    func bindViewModel() {
            viewModel.productDetailsFetched = { [weak self] in
                self?.ProductDetailCollectionView.reloadData()
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let index = sender as? Int {
                let vc = segue.destination as! ProductViewController
                vc.categoryProductDetail = viewModel.productDetailList[index]  // Seçilen ürün detayını gönderiyoruz
            }
        }
}
extension ProductDetailViewController : UICollectionViewDelegate , UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productDetailList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productDetail = viewModel.productDetailList[indexPath.row]
        let cell = ProductDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "productDetailCell", for: indexPath) as! ProductDetailCollectionViewCell
        cell.productDetailName.text = productDetail.productDetailName
        cell.productDetailPrice.text = String(format: "%.2f ₺", productDetail.productDetailPrice!) 
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
