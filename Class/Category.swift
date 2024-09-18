//
//  Category.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 17.09.2024.
//

import Foundation

class Category :Codable{
    
    var categoryName : String?
    var categoryId: String?
    var categoryImage : String?
    
    init(){
    }
    
    init(categoryName: String, categoryId: String, categoryImage: String) {
        self.categoryName = categoryName
        self.categoryId = categoryId
        self.categoryImage = categoryImage
    }
    
    
    
    
}
