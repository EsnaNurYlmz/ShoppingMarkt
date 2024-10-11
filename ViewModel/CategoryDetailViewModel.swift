//
//  CategoryDetailViewModel.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 9.10.2024.
//
/*
import Foundation

class CategoryDetailViewModel {
    var categoryDetailList : [CategoryDetail] = []{
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var reloadTableViewClosure: (()->())?
    
    func fetchCategoryDetail(categoryId:Int){
        var request = URLRequest(url: URL(string: "")!)
        request.httpMethod = "POST"
        let postString = "categori_id=\(categoryId)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request){ data , response , error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            do{
                let CategoryDetailreponse = try JSONDecoder().decode(CategoryDetailResponse.self, from: data!)
                if let getCategoryDetailList = CategoryDetailreponse.categoryDetail{
                    self.categoryDetailList = getCategoryDetailList
                }
                DispatchQueue.main.async {
                    self.categoryDetailList.reloadData();
                }
                
                
                
            }
        }
        
        
    }
}
*/
