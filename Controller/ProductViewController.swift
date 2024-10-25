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
    var categoryProductDetail: ProductDetail?
    
    var pickerView: UIPickerView!
    var viewModel: ProductViewModel?
    let sizes = ["S", "M", "L", "XL"]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = false
        configureView()
        setupPickerView()
        bindViewModel()
    }
    
    func configureView() {
            if let product = viewModel?.categoryProductDetail {
                productNameLabel.text = product.productDetailName
                productPriceLabel.text = String(format: "%.2f ₺", product.productDetailPrice!)
                productFeaturesLabel.text = product.productDetailFeatures
                
                // Ürün görselini yükle
                viewModel?.loadProductImage { [weak self] data in
                    if let imageData = data {
                        self?.productImage.image = UIImage(data: imageData)
                    }
                }
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
    // ViewModel ile ViewController'ı bağlama
        func bindViewModel() {
            viewModel?.favoriteUpdated = { [weak self] in
                self?.performSegue(withIdentifier: "tofavorite", sender: nil)
            }
            viewModel?.cartUpdated = { [weak self] in
                self?.performSegue(withIdentifier: "toCart", sender: nil)
            }
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
           let selectedSize = sizes[row]
            selectSizeButton.setTitle("Size: \(selectedSize)", for: .normal) // Seçilen bedeni butona yaz
            pickerView.isHidden = true // Beden seçimi yapılınca picker'ı gizle
        }
    
    @IBAction func addToFavoritesTapped(_ sender: UIBarButtonItem) {
        viewModel?.addToFavorites()
    }
    
    @IBAction func addToCartTapped(_ sender: UIBarButtonItem) {
        viewModel?.addToCart()
    }
}
