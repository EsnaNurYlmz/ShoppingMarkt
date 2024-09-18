//
//  Products.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 18.09.2024.
//

import Foundation

class Products : Codable {
    
    var productId : String?
    var productName : String?
    var productImage : String?
    
    init(){
    }
    
    init(productId: String, productName: String, productImage: String) {
        self.productId = productId
        self.productName = productName
        self.productImage = productImage
    }
    
    
    
}

