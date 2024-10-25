//
//  CartViewModel.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 25.10.2024.
//

import Foundation

class CartViewModel {
    var cartProductList = [ProductDetail]() {
        didSet {
            saveCart()
        }
    }
    
    init() {
        loadCart()
    }
    
    // Sepet ürünlerini UserDefaults'a kaydetmek
    private func saveCart() {
        if let encodedData = try? JSONEncoder().encode(cartProductList) {
            UserDefaults.standard.set(encodedData, forKey: "cart")
            print("Sepet ürünleri kaydedildi.")
        }
    }
    
    // Sepet ürünlerini UserDefaults'tan yüklemek
    private func loadCart() {
        if let savedData = UserDefaults.standard.data(forKey: "cart"),
           let decodedData = try? JSONDecoder().decode([ProductDetail].self, from: savedData) {
            cartProductList = decodedData
            print("Sepet ürünleri yüklendi.")
        }
    }
    
    // Sepetten bir ürünü kaldırmak
    func removeProduct(at index: Int) {
        cartProductList.remove(at: index)
    }
    
    // Sepet ürün sayısını almak
    func getCartCount() -> Int {
        return cartProductList.count
    }
    
    // Sepet ürünlerini almak
    func getProduct(at index: Int) -> ProductDetail {
        return cartProductList[index]
    }
}
