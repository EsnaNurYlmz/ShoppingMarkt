//
//  ProductDetailViewModel.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 25.10.2024.
//

import Foundation

class ProductDetailViewModel {
    
    var productDetailList: [ProductDetail] = []
    
    var productDetailsFetched: (() -> Void)?
    
    func fetchProductDetail(productId: Int) {
        var request = URLRequest(url: URL(string: "")!)
        request.httpMethod = "POST"
        let postString = "category_id=\(productId)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil || data == nil {
                print("Error fetching product details: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let responseProductDetail = try JSONDecoder().decode(ProductDetailResponse.self, from: data!)
                if let fetchedProductDetails = responseProductDetail.productDetail {
                    self.productDetailList = fetchedProductDetails
                    DispatchQueue.main.async {
                        self.productDetailsFetched?()
                    }
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
