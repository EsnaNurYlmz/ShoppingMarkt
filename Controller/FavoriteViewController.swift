//
//  FavoriteViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 16.09.2024.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    var favoriteList = [ProductDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
        loadFavorites()
    }
    
    // Favori ürünleri UserDefaults'a kaydetmek için kullanıyor
        func saveFavorites() {
            if let encodedData = try? JSONEncoder().encode(favoriteList) {
                UserDefaults.standard.set(encodedData, forKey: "favorites")
                print("Favoriler kaydedildi.")
            }
        }
        
        // Favori ürünleri UserDefaults'tan yüklemek için kullanıyor
        func loadFavorites() {
            if let savedData = UserDefaults.standard.data(forKey: "favorites"),
               let decodedData = try? JSONDecoder().decode([ProductDetail].self, from: savedData) {
                favoriteList = decodedData
                print("Favoriler yüklendi.")
            }
        }
}
extension FavoriteViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favoriteProducts = favoriteList[indexPath.row]
        let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCollectionViewCell
        cell.favoriteProductName.text = favoriteProducts.productDetailName
        cell.favoriteProductPrice.text = String(format: "%.2f ₺", favoriteProducts.productDetailPrice!)
        if let url = URL(string: " /\(favoriteProducts.productDetailImage!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.favoriteImage.image = UIImage(data: data!)
                }
            }
        }
        cell.favoriteImage.image = UIImage(named: favoriteProducts.productDetailImage!)
        return cell
    }
    // Hücreyi sağa kaydırarak silmek için bu metodu
        func collectionView(_ collectionView: UICollectionView, trailingSwipeActionsConfigurationForItemAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { [weak self] (action, view, completionHandler) in
                // Favoriler listesinden ürünü kaldır
                self?.favoriteList.remove(at: indexPath.row)
                self?.saveFavorites() // Güncellenen favori listesini kaydet
                collectionView.deleteItems(at: [indexPath]) // CollectionView'den hücreyi kaldır
                
                completionHandler(true) // İşlem tamamlandı
            }
            deleteAction.backgroundColor = .red // Silme butonunun arka plan rengi
            
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
        }
}
