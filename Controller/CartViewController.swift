//
//  CartViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 16.09.2024.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var cartCollectionView: UICollectionView!
    var cartProductList = [ProductDetail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
       
        loadCart()
    }
    
    func saveCart() {
        if let encodedData = try? JSONEncoder().encode(cartProductList) {
            UserDefaults.standard.set(encodedData, forKey: "cart")
            print("Sepete ürün kaydedildi.")
        }
    }
    
    // Favori ürünleri UserDefaults'tan yüklemek için kullanıyor
    func loadCart() {
        if let savedData = UserDefaults.standard.data(forKey: "cart"),
           let decodedData = try? JSONDecoder().decode([ProductDetail].self, from: savedData) {
            cartProductList = decodedData
            print("Sepete ürün yüklendi.")
        }
    }
    
    
}
extension CartViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartProductList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let CartList = cartProductList[indexPath.row]
        let cell = cartCollectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath) as! CartCollectionViewCell
        cell.cartProductName.text = CartList.productDetailName
        cell.cartProductPrice.text = String(format: "%.2f ₺", CartList.productDetailPrice!)
        cell.productPrice = CartList.productDetailPrice!
          cell.quantityStepper.value = 1
          cell.quantityStepper.minimumValue = 1
        if let url = URL(string: " /\(CartList.productDetailImage!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.cartImage.image = UIImage(data: data!)
                }
            }
        }
        cell.cartImage.image = UIImage(named: CartList.productDetailImage!)
        return cell
    }
    // Hücreyi sağa kaydırarak silmek için bu metodu
        func collectionView(_ collectionView: UICollectionView, trailingSwipeActionsConfigurationForItemAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { [weak self] (action, view, completionHandler) in
                //Sepet listesinden ürünü kaldır
                self?.cartProductList.remove(at: indexPath.row)
                self?.saveCart() // Güncellenen sepet listesini kaydet
                collectionView.deleteItems(at: [indexPath]) // CollectionView'den hücreyi kaldır
                completionHandler(true) // İşlem tamamlandı
            }
            deleteAction.backgroundColor = .red // Silme butonunun arka plan rengi
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
        }
}

