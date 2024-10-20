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
    var categoryProduct : Products?
    var selectedCategoryId : Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        ProductDetailCollectionView.dataSource = self
        ProductDetailCollectionView.delegate = self
        
        if let category_id = selectedCategoryId {
            fetchProductDetail(productId: category_id)
        }
    }
    func fetchProductDetail(productId:Int){
        var request = URLRequest(url: URL(string: "")!)
        request.httpMethod = "POST"
        let postString = "category_id=\(productId)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data , response , error in
            if error != nil || data == nil {
                print("Error")
                return
            }
            do{
                let ResponseProductDetail = try JSONDecoder().decode(ProductDetailResponse.self, from: data!)
                if let getProductDetailList = ResponseProductDetail.productDetail {
                    self.productDetailList = getProductDetailList
                }
                
                DispatchQueue.main.async {
                    self.ProductDetailCollectionView.reloadData()
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let VC = segue.destination as! ProductViewController
        VC.categoryProductDetail = productDetailList[indeks!]
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
