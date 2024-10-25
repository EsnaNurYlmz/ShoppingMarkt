//
//  ProductsViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 18.09.2024.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var ProductsCollectionView: UICollectionView!
    var viewModel = ProductsViewModel()
    var categoryDetail: CategoryDetail?
    var selectedCategoryId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductsCollectionView.dataSource = self
        ProductsCollectionView.delegate = self
        
        bindViewModel()
        if let categoryId = selectedCategoryId {
                   viewModel.fetchProducts(categoryDetailId: categoryId)
               }
    }
    func bindViewModel() {
            viewModel.productsFetched = { [weak self] in
                self?.ProductsCollectionView.reloadData()
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let index = sender as? Int {
                let vc = segue.destination as! ProductDetailViewController
                vc.categoryProduct = viewModel.productsList[index]
            }
        }
}
extension ProductsViewController : UICollectionViewDataSource , UICollectionViewDelegate {
     
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = viewModel.productsList[indexPath.row]
        let cell = ProductsCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath) as! ProductsCollectionViewCell
        cell.productName.text = product.productName
        
        if let url = URL(string: " /\(product.productImage!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.productImage.image = UIImage(data: data!)
                }
            }
        }
        cell.productImage.image = UIImage(named: product.productImage!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toProductDetail", sender: nil)
    }
}
