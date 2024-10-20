//
//  ProductDetail.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 18.09.2024.
//

import Foundation

class ProductDetail : Codable {
    
    var productDetailId : String?
    var productDetailName : String?
    var productDetailImage : String?
    var productDetailPrice : Double?
    var productDetailFeatures : String?
    
    init(){
    }
    
    init(productDetailId: String, productDetailName: String, productDetailImage: String, productDetailPrice: Double, productDetailFeatures: String) {
        self.productDetailId = productDetailId
        self.productDetailName = productDetailName
        self.productDetailImage = productDetailImage
        self.productDetailPrice = productDetailPrice
        self.productDetailFeatures = productDetailFeatures

    }
    
}
