//
//  CartCollectionViewCell.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 2.10.2024.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var cartProductName: UILabel!
    @IBOutlet weak var cartProductPrice: UILabel!
    
    var productPrice: Double = 0.0
    override func awakeFromNib() {
            super.awakeFromNib()
            quantityStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        }
    @objc func stepperValueChanged(_ sender: UIStepper) {
           let totalPrice = productPrice * sender.value
           cartProductPrice.text = String(format: "%.2f ₺", totalPrice)
       }
}
