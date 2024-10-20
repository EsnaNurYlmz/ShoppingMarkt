//
//  AccountViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 16.09.2024.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var accountTableView: UITableView!
    let accountCategory = ["GİRİŞ","ÜYELİK","FAVORİLER","SEPET","ÇIKIŞ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountTableView.dataSource = self
        accountTableView.delegate = self

    }
}
extension AccountViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCategory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  accountList = accountCategory[indexPath.row]
        let cell = accountTableView.dequeueReusableCell(withIdentifier: "AccountCell") as! AccountTableViewCell
        cell.accountLabel.text = accountList
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = accountCategory[indexPath.row]
        
        switch selectedCategory {
        case "GİRİŞ":
            performSegue(withIdentifier: "toSignInVC", sender: self)
            
        case "ÜYELİK":
            performSegue(withIdentifier: "toSignUpVC", sender: self)
    
        case "FAVORİLER" :
            performSegue(withIdentifier: "toFavoriteVC", sender: self)

        case "SEPET" :
            performSegue(withIdentifier: "toCartVC", sender: self)
            
        case "ÇIKIŞ" :
            print("ÇIKIŞ yapılıyor...")
        default:
            break
        }
    }
}

