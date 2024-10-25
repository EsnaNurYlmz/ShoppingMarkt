//
//  ProductsViewModel.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 25.10.2024.
//

import Foundation

class ProductsViewModel {
    var productsList: [Products] = []
    
    var productsFetched: (() -> Void)?
    
    func fetchProducts(categoryDetailId: Int) {
        var request = URLRequest(url: URL(string: "")!)
        request.httpMethod = "POST"
        let postString = "category_id=\(categoryDetailId)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil || data == nil {
                print("Error fetching products: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let responseProducts = try JSONDecoder().decode(ProductsResponse.self, from: data!)
                if let fetchedProducts = responseProducts.products {
                    self.productsList = fetchedProducts
                    DispatchQueue.main.async {
                        self.productsFetched?()
                    }
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
}

