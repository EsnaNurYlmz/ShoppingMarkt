//
//  CategoriesViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 16.09.2024.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var categoryTableView: UITableView!
    var categoryList = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        
        fetchCategories()
    }
    
    func fetchCategories() {
        let url = URL(string: " ")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Error")
                return
            }
            do {
                let ResponseCategory = try JSONDecoder().decode(CategoryResponse.self, from: data!)
                if let getCategoryList = ResponseCategory.category {
                    self.categoryList = getCategoryList
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let VC = segue.destination as! CategoryDetailViewController
        VC.category = categoryList[indeks!]
    }
}

extension CategoriesViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categoryList[indexPath.row]
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
