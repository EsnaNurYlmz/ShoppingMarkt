//
//  ProductViewModel.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 25.10.2024.
//

import Foundation

class ProductViewModel {
    
    var categoryProductDetail: ProductDetail?
    var selectedSize: String?
    
    // Favori ürünlerin güncellenmesi ile ilgili bir closure
    var favoriteUpdated: (() -> Void)?
    
    // Sepet ürünlerin güncellenmesi ile ilgili bir closure
    var cartUpdated: (() -> Void)?
    
    init(productDetail: ProductDetail?) {
        self.categoryProductDetail = productDetail
    }
    
    // Favorilere ürün ekleme
    func addToFavorites() {
        guard let productFavorite = categoryProductDetail else { return }
        var favoriteProducts = getFavoriteProducts()
        favoriteProducts.append(productFavorite)
        
        if let encodedData = try? JSONEncoder().encode(favoriteProducts) {
            UserDefaults.standard.set(encodedData, forKey: "favorites")
            favoriteUpdated?()
            print("Ürün favorilere eklendi")
        }
    }
    
    // Favori ürünleri yükleme
    func getFavoriteProducts() -> [ProductDetail] {
        if let savedData = UserDefaults.standard.data(forKey: "favorites"),
           let favoriteProducts = try? JSONDecoder().decode([ProductDetail].self, from: savedData) {
            return favoriteProducts
        }
        return []
    }
    
    // Sepete ürün ekleme
    func addToCart() {
        guard let productCart = categoryProductDetail else { return }
        var cartProducts = getCartProducts()
        cartProducts.append(productCart)
        
        if let encodedData = try? JSONEncoder().encode(cartProducts) {
            UserDefaults.standard.set(encodedData, forKey: "cart")
            cartUpdated?()
            print("Ürün sepete eklendi")
        }
    }
    
    // Sepet ürünlerini yükleme
    func getCartProducts() -> [ProductDetail] {
        if let saveData = UserDefaults.standard.data(forKey: "cart"),
           let cartProducts = try? JSONDecoder().decode([ProductDetail].self, from: saveData) {
            return cartProducts
        }
        return []
    }
    
    // Ürün görselini yüklemek için
    func loadProductImage(completion: @escaping (Data?) -> Void) {
        if let product = categoryProductDetail, let urlString = product.productDetailImage, let url = URL(string: urlString) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        } else {
            completion(nil)
        }
    }
}
