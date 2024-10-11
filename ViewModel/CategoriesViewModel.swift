//
//  CategoriesViewModel.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 9.10.2024.
//
/*
import Foundation

class CategoriesViewModel {
    
    var categoryList: [Category] = [] {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var reloadTableViewClosure: (()->())?
    
    func fetchCategories() {
        let url = URL(string: " ")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Kategoriler getirilirken hata oluştu")
                return
            }
            do {
                let responseCategory = try JSONDecoder().decode(CategoryResponse.self, from: data!)
                if let getCategoryList = responseCategory.category {
                    self.categoryList = getCategoryList
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
*/
