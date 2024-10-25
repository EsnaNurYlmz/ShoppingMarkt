//
//  FavoriteViewModel.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 25.10.2024.
//

import Foundation

class FavoriteViewModel {
    var favoriteList = [ProductDetail]() {
        didSet {
            saveFavorites()
        }
    }
    
    init() {
        loadFavorites()
    }
    
    // Favori ürünleri UserDefaults'a kaydetmek
    private func saveFavorites() {
        if let encodedData = try? JSONEncoder().encode(favoriteList) {
            UserDefaults.standard.set(encodedData, forKey: "favorites")
            print("Favoriler kaydedildi.")
        }
    }
    
    // Favori ürünleri UserDefaults'tan yüklemek
    private func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: "favorites"),
           let decodedData = try? JSONDecoder().decode([ProductDetail].self, from: savedData) {
            favoriteList = decodedData
            print("Favoriler yüklendi.")
        }
    }
    
    // Favorilerden bir ürünü silmek
    func removeFavorite(at index: Int) {
        favoriteList.remove(at: index)
    }
    
    // Favori listesini getirmek
    func getFavorite(at index: Int) -> ProductDetail {
        return favoriteList[index]
    }
    
    // Favori listesi sayısını getirmek
    func getFavoritesCount() -> Int {
        return favoriteList.count
    }
}
