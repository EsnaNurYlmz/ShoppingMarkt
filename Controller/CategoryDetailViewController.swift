//
//  CategoryDetailViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 18.09.2024.
//

import UIKit

class CategoryDetailViewController: UIViewController {
    
    @IBOutlet weak var CategoryDetailCollectionView: UICollectionView!
    var viewModel = CategoryDetailViewModel()
    var selectedCategoryId: Int?
    var category: Category?

    override func viewDidLoad() {
        super.viewDidLoad()
       
        CategoryDetailCollectionView.dataSource = self
        CategoryDetailCollectionView.delegate = self
        
        setupBindings()
        
        if let category_id = selectedCategoryId {
            viewModel.fetchCategoryDetail(categoryId: category_id)
        }
    }
    func setupBindings() {
        viewModel.didUpdateCategoryDetails = { [weak self] in
            DispatchQueue.main.async {
                self?.CategoryDetailCollectionView.reloadData()
            }
        }
        
        viewModel.didFailWithError = { error in
            print("Error: \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = CategoryDetailCollectionView.indexPathsForSelectedItems?.first?.row {
            let destinationVC = segue.destination as! ProductsViewController
            destinationVC.categoryDetail = viewModel.categoryDetailList[index]
        }
        
    }
}

extension CategoryDetailViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categoryDetailList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryDetail = viewModel.categoryDetailList[indexPath.row]
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
