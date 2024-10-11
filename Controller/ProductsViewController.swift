//
//  ProductsViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 18.09.2024.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var ProductsCollectionView: UICollectionView!
    var productsList = [Products]()
    var categoryDetail : CategoryDetail?
    var selectedCategoryId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductsCollectionView.dataSource = self
        ProductsCollectionView.delegate = self
        
        if let category_id = selectedCategoryId {
            fetchProducts(categoryDetailId: category_id)
        }
    }
    func fetchProducts(categoryDetailId:Int){
        var request = URLRequest(url: URL(string: "")!)
        request.httpMethod = "POST"
        let postString = "category_id=\(categoryDetailId)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data , response , error in
            if error != nil || data == nil {
                print("Error")
                return
            }
            do{
                let ResponseProducts = try JSONDecoder().decode(ProductsResponse.self, from: data!)
                if let getProductsList = ResponseProducts.products {
                    self.productsList = getProductsList
                }
                
                DispatchQueue.main.async {
                    self.ProductsCollectionView.reloadData()
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let VC = segue.destination as! ProductDetailViewController
        VC.categoryProduct = productsList[indeks!]
    }
}

extension ProductsViewController : UICollectionViewDataSource , UICollectionViewDelegate {
     
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = productsList[indexPath.row]
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
