//
//  ProductViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 20.09.2024.
//

import UIKit

class ProductViewController: UIViewController ,UIPickerViewDelegate , UIPickerViewDataSource {
      
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var selectSizeButton: UIButton!
    @IBOutlet weak var productFeaturesLabel: UILabel!
    
    var pickerView: UIPickerView!
    var categoryProductDetail : ProductDetail?
    let sizes = ["S", "M", "L", "XL"]
    var selectedSize: String?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = false
        configureView()
        setupPickerView()
    }
    
    func configureView(){
        if let product = categoryProductDetail {
            
            if let url = URL(string: " /\(product.productDetailImage!)"){
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        self.productImage.image = UIImage(data: data!)
                    }
                }
            }
            productNameLabel.text = product.productDetailName
            productPriceLabel.text =  String(format: "%.2f ₺", product.productDetailPrice!)  
            productFeaturesLabel.text = product.productDetailFeatures
        }
    }
    // UIPickerView ayarları
       func setupPickerView() {
           pickerView = UIPickerView()
              pickerView.delegate = self
              pickerView.dataSource = self
              pickerView.isHidden = true // Başlangıçta gizli olacak
              pickerView.backgroundColor = .white
              
              // Picker'ın Beden butonunun altına yerleştirilmesi
              let buttonFrame = selectSizeButton.frame
              pickerView.frame = CGRect(x: buttonFrame.origin.x,
                                        y: buttonFrame.origin.y + buttonFrame.height,
                                        width: buttonFrame.width,
                                        height: 150) // Picker'ın yüksekliğini ayarlayabilirsiniz
              view.addSubview(pickerView)
       }
   
    @IBAction func selectSizeButtonTapped(_ sender: UIButton) {
        pickerView.isHidden = !pickerView.isHidden

    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        // PickerView'de kaç adet satır olacak
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return sizes.count
        }

        // Her satırda ne gösterilecek
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return sizes[row]
        }

        // Kullanıcı bir beden seçtiğinde ne olacak
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedSize = sizes[row]
            selectSizeButton.setTitle("Size: \(selectedSize!)", for: .normal) // Seçilen bedeni butona yaz
            pickerView.isHidden = true // Beden seçimi yapılınca picker'ı gizle
        }
    
    @IBAction func addToFavoritesTapped(_ sender: UIBarButtonItem) {
        if let productFavorite = categoryProductDetail {
            var favoriteProducts = getFavoriteProducts()
            favoriteProducts.append(productFavorite)
            
            if let encodedData = try? JSONEncoder().encode(favoriteProducts) {
                           UserDefaults.standard.set(encodedData, forKey: "favorites")
                           print("Ürün favorilere eklendi")
                       }
        }
            performSegue(withIdentifier: "tofavorite", sender: nil)
    }
    func getFavoriteProducts() -> [ProductDetail] {
            if let savedData = UserDefaults.standard.data(forKey: "favorites"),
               let favoriteProducts = try? JSONDecoder().decode([ProductDetail].self, from: savedData) {
                return favoriteProducts
            }
            return []
        }
    
    @IBAction func addToCartTapped(_ sender: UIBarButtonItem) {
        if let productCart = categoryProductDetail {
            var cartProducts = getCartProducts()
            cartProducts.append(productCart)
            
            if let encodedData = try? JSONEncoder().encode(cartProducts){
                UserDefaults.standard.set(encodedData, forKey: "cart")
                print("ürün sepete eklendi")
            }
        }
        performSegue(withIdentifier: "toCart", sender: nil) // Sepet sayfasına geçiş
    }
            
    func getCartProducts() -> [ProductDetail] {
        if let  saveData = UserDefaults.standard.data(forKey: "cart"),
           let cartProducts = try? JSONDecoder().decode([ProductDetail].self, from: saveData) {
            return cartProducts
        }
        return []
    }
}
