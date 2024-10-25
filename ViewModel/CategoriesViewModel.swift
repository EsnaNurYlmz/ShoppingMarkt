//
//  CategoriesViewModel.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 9.10.2024.
//

import Foundation

class CategoriesViewModel {
    
    var categoryList = [Category]()
    
    var didUpdateCategories: (() -> Void)?
    var didFailWithError: ((String) -> Void)?
    
    func fetchCategories() {
        let url = URL(string: " ")!
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                self.didFailWithError?(error.localizedDescription)
                return
            }
            guard let data = data else {
                self.didFailWithError?("No data")
                return
            }
            do {
                let responseCategory = try JSONDecoder().decode(CategoryResponse.self, from: data)
                if let categories = responseCategory.category {
                    self.categoryList = categories
                    self.didUpdateCategories?()
                }
            } catch {
                self.didFailWithError?("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
}
