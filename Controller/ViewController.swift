//
//  ViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 9.09.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var advertCollectionView: UICollectionView!
    @IBOutlet weak var CategoryAdvertCollectionView: UICollectionView!
    @IBOutlet weak var PromotionalProductsCollectionView: UICollectionView!
    
    let advertImage = ["advert5","advert3","advert4"]
    let CategoryAdvertImage = ["cat1","cat2","cat9","cat7"]
    let PromotionaProductsImage = ["p2","p3","p4","p5","p6","p8","p7","p9","p1","p10"]
    var list:[String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = ["Giyim","Elektronik","Kozmetik","Mobilya"]
        
        advertCollectionView.dataSource = self
        advertCollectionView.delegate = self
        
        CategoryAdvertCollectionView.dataSource = self
        CategoryAdvertCollectionView.delegate = self
        
        PromotionalProductsCollectionView.dataSource = self
        PromotionalProductsCollectionView.delegate = self
       
        if let layout = advertCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
       advertCollectionView.isPagingEnabled = true
        
       if let layout = CategoryAdvertCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
          if let layout = PromotionalProductsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        
    }
}
extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == advertCollectionView {
            return advertImage.count
        }else if collectionView == CategoryAdvertCollectionView {
            return CategoryAdvertImage.count
        }else if collectionView == PromotionalProductsCollectionView {
            return PromotionaProductsImage.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == advertCollectionView {
            let cell = advertCollectionView.dequeueReusableCell(withReuseIdentifier: "advertCell", for: indexPath) as! AdvertCollectionViewCell
            cell.advertImage.image = UIImage(named: advertImage[indexPath.item])
            return cell
        }else if collectionView == CategoryAdvertCollectionView{
            let cell = CategoryAdvertCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryAdvertCell", for: indexPath) as! CategoryAdvertCollectionViewCell
            cell.CategoriImage.image = UIImage(named: CategoryAdvertImage[indexPath.item])
            cell.CategoriLabel?.text = list[indexPath.item]
            return cell
            
        }else if collectionView == PromotionalProductsCollectionView {
            let cell = PromotionalProductsCollectionView.dequeueReusableCell(withReuseIdentifier: "PromotionalProductsCell", for: indexPath) as! PromotionalProductsCollectionViewCell
            cell.ProProductImage.image = UIImage(named: PromotionaProductsImage[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == advertCollectionView{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

        }else if collectionView == CategoryAdvertCollectionView{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

        }else if collectionView == PromotionalProductsCollectionView{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        return CGSize.zero
    }
}
