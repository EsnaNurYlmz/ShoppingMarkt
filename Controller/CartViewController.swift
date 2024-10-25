//
//  CartViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 16.09.2024.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var cartCollectionView: UICollectionView!
    var viewModel = CartViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
    }
    
    
}
extension CartViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCartCount()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cartProduct = viewModel.getProduct(at: indexPath.row)
                let cell = cartCollectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath) as! CartCollectionViewCell
                
                cell.cartProductName.text = cartProduct.productDetailName
                cell.cartProductPrice.text = String(format: "%.2f ₺", cartProduct.productDetailPrice!)
                cell.productPrice = cartProduct.productDetailPrice!
                cell.quantityStepper.value = 1
                cell.quantityStepper.minimumValue = 1
                
                if let url = URL(string: "/\(cartProduct.productDetailImage!)") {
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url) {
                            DispatchQueue.main.async {
                                cell.cartImage.image = UIImage(data: data)
                            }
                        }
                    }
                }
                cell.cartImage.image = UIImage(named: cartProduct.productDetailImage!)
                return cell
    }
    // Hücreyi sağa kaydırarak silmek için bu metodu
        func collectionView(_ collectionView: UICollectionView, trailingSwipeActionsConfigurationForItemAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { [weak self] (action, view, completionHandler) in
                        self?.viewModel.removeProduct(at: indexPath.row)
                        collectionView.deleteItems(at: [indexPath])
                        completionHandler(true)
                    }
                    deleteAction.backgroundColor = .red
                    let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
                    return configuration
        }
}

