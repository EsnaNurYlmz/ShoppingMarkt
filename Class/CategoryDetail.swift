//
//  CategoryDetail.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 18.09.2024.
//

import Foundation

class CategoryDetail : Codable {

    var categoryDetailId : String?
    var categoryDetailName : String?
    var categoryDetailImage : String?
    
    init(){
    }
    
    init(categoryDetailId : String, categoryDetailName: String, categoryDetailImage: String) {
        self.categoryDetailName = categoryDetailName
        self.categoryDetailImage = categoryDetailImage
        self.categoryDetailId = categoryDetailId
    }
}
