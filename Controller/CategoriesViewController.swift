//
//  CategoriesViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 16.09.2024.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var categoryTableView: UITableView!
    var viewModel = CategoriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        
        setupBindings()
        viewModel.fetchCategories()
    }
    func setupBindings() {
            viewModel.didUpdateCategories = { [weak self] in
                DispatchQueue.main.async {
                    self?.categoryTableView.reloadData()
                }
            }
            
            viewModel.didFailWithError = { error in
                print("Error: \(error)")
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let index = categoryTableView.indexPathForSelectedRow?.row {
                let destinationVC = segue.destination as! CategoryDetailViewController
                destinationVC.category = viewModel.categoryList[index]
            }
        }

}

extension CategoriesViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categoryList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = viewModel.categoryList[indexPath.row]
        let cell = categoryTableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        cell.categoryName.text = category.categoryName
        
        if let url = URL(string: " /\(category.categoryImage!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.categoryImage.image = UIImage(data: data!)
                }
            }
        }
        cell.categoryImage.image = UIImage(named: category.categoryImage!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "toCategoryDetail", sender: nil)
    }
}
