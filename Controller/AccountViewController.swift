//
//  AccountViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 16.09.2024.
//

import UIKit

class AccountViewController: UIViewController {
    
    var viewModel = AccountViewModel()
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var accountTableView: UITableView!
    let accountCategory = ["GİRİŞ","ÜYELİK","FAVORİLER","SEPET","ÇIKIŞ","HESABI SİL"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountTableView.dataSource = self
        accountTableView.delegate = self
        viewModel.fetchUserName()
        userName.text = viewModel.userName
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.tabBarController?.tabBar.isHidden = false
            userName.text = viewModel.userName
        }
    func handleAction(for category: String) {
            switch category {
            case "GİRİŞ":
                performSegue(withIdentifier: "toSignInVC", sender: self)
                
            case "ÜYELİK":
                performSegue(withIdentifier: "toSignUpVC", sender: self)
        
            case "FAVORİLER":
                performSegue(withIdentifier: "toFavoriteVC", sender: self)

            case "SEPET":
                performSegue(withIdentifier: "toCartVC", sender: self)
                
            case "ÇIKIŞ":
                viewModel.logOut()
                userName.text = viewModel.userName
                performSegue(withIdentifier: "toSignInVC", sender: nil)
                
            case "HESABI SİL":
                let alert = UIAlertController(title: "Hesap Sil", message: "Hesabınızı silmek istediğinize emin misiniz?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Evet", style: .destructive, handler: { _ in
                    self.viewModel.deleteUser()
                    self.userName.text = self.viewModel.userName
                    print("Hesap silindi.")
                }))
                alert.addAction(UIAlertAction(title: "Hayır", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
                
            default:
                break
            }
        }
}
extension AccountViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCategoryCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let accountList = viewModel.getCategory(at: indexPath.row)
                let cell = accountTableView.dequeueReusableCell(withIdentifier: "AccountCell") as! AccountTableViewCell
                cell.accountLabel.text = accountList
                return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = viewModel.getCategory(at: indexPath.row)
               handleAction(for: selectedCategory)
    }
}

