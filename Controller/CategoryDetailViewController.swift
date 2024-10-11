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
    var selectedCategoryId : Int?
    var category : Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CategoryDetailCollectionView.dataSource = self
        CategoryDetailCollectionView.delegate = self
        
        if let category_id = selectedCategoryId {
            fetchCategoryDetail(categoryId: category_id)
        }
    }
    
    func fetchCategoryDetail(categoryId:Int){
        var request = URLRequest(url: URL(string: "")!)
        request.httpMethod = "POST"
        let postString = "category_id=\(categoryId)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data , response , error in
            if error != nil || data == nil {
                print("Error")
                return
            }
            do{
                let ResponseCategoryDetail = try JSONDecoder().decode(CategoryDetailResponse.self, from: data!)
                if let getCategoryDetailList = ResponseCategoryDetail.categoryDetail {
                    self.categoryDetailList = getCategoryDetailList
                }
                DispatchQueue.main.async {
                    self.CategoryDetailCollectionView.reloadData()
                }
            }catch{
                print(error.localizedDescription)
            }
            }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let VC = segue.destination as! ProductsViewController
        VC.categoryDetail = categoryDetailList[indeks!]
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
