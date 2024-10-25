//
//  CategoryDetailViewModel.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 9.10.2024.
//

import Foundation

class CategoryDetailViewModel {
    
    var categoryDetailList = [CategoryDetail]()
       var didUpdateCategoryDetails: (() -> Void)?
       var didFailWithError: ((String) -> Void)?
       
       func fetchCategoryDetail(categoryId: Int) {
           var request = URLRequest(url: URL(string: "")!)
           request.httpMethod = "POST"
           let postString = "category_id=\(categoryId)"
           request.httpBody = postString.data(using: .utf8)
           
           URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
               guard let self = self else { return }
               if let error = error {
                   self.didFailWithError?(error.localizedDescription)
                   return
               }
               guard let data = data else {
                   self.didFailWithError?("No data available")
                   return
               }
               do {
                   let responseCategoryDetail = try JSONDecoder().decode(CategoryDetailResponse.self, from: data)
                   if let details = responseCategoryDetail.categoryDetail {
                       self.categoryDetailList = details
                       self.didUpdateCategoryDetails?()
                   }
               } catch {
                   self.didFailWithError?("Decoding error: \(error.localizedDescription)")
               }
           }.resume()
       }
    
}

