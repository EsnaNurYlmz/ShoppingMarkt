//
//  FavoriteViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 16.09.2024.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    var viewModel = FavoriteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
    }
}
extension FavoriteViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getFavoritesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favoriteProducts = viewModel.getFavorite(at: indexPath.row)
                let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCollectionViewCell
                cell.favoriteProductName.text = favoriteProducts.productDetailName
                cell.favoriteProductPrice.text = String(format: "%.2f ₺", favoriteProducts.productDetailPrice!)
                
                if let url = URL(string: "/\(favoriteProducts.productDetailImage!)") {
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url) {
                            DispatchQueue.main.async {
                                cell.favoriteImage.image = UIImage(data: data)
                            }
                        }
                    }
                }
                cell.favoriteImage.image = UIImage(named: favoriteProducts.productDetailImage!)
                return cell
    }
    // Hücreyi sağa kaydırarak silmek için bu metodu
        func collectionView(_ collectionView: UICollectionView, trailingSwipeActionsConfigurationForItemAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { [weak self] (action, view, completionHandler) in
                        self?.viewModel.removeFavorite(at: indexPath.row)
                        collectionView.deleteItems(at: [indexPath])
                        completionHandler(true)
                    }
                    deleteAction.backgroundColor = .red
                    let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
                    return configuration
        }
}
