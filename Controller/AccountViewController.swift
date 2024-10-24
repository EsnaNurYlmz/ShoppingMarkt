//
//  AccountViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 16.09.2024.
//

import UIKit
import CoreData

class AccountViewController: UIViewController {
    var loggedInUserEmail: String?

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var accountTableView: UITableView!
    let accountCategory = ["GİRİŞ","ÜYELİK","FAVORİLER","SEPET","ÇIKIŞ","HESABI SİL"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountTableView.dataSource = self
        accountTableView.delegate = self
        if let email = UserDefaults.standard.string(forKey: "loggedInUserEmail") {
                    fetchUserName(email: email)
                }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    func fetchUserName(email: String) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            
            do {
                let results = try context.fetch(fetchRequest)
                if let user = results.first as? NSManagedObject, let name = user.value(forKey: "name") as? String {
                    userName.text = name
                }
            } catch {
                print("Kullanıcı adı çekme hatası: \(error.localizedDescription)")
            }
        }
    func deleteUser(email: String) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            
            do {
                let results = try context.fetch(fetchRequest)
                if let user = results.first as? NSManagedObject {
                    context.delete(user)
                    try context.save()
                    print("Kullanıcı başarıyla silindi.")
                }
            } catch {
                print("Kullanıcı silme hatası: \(error.localizedDescription)")
            }
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
            UserDefaults.standard.removeObject(forKey: "loggedInUserEmail")
                        // Oturum kapatıldı
                        userName.text = "kullanıcı adı"
                        performSegue(withIdentifier: "toSignInVC", sender: nil)
            print("ÇIKIŞ yapılıyor...")
        case "HESABI SİL" :
            let alert = UIAlertController(title: "Hesap Sil", message: "Hesabınızı silmek istediğinize emin misiniz?", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "Evet", style: .destructive, handler: { _ in
                           if let email = UserDefaults.standard.string(forKey: "loggedInUserEmail") {
                               self.deleteUser(email: email)
                               UserDefaults.standard.removeObject(forKey: "loggedInUserEmail")
                               self.userName.text = "kullanıcı adı"
                               print("Hesap silindi.")
                           }
                       }))
                       alert.addAction(UIAlertAction(title: "Hayır", style: .cancel, handler: nil))
                       present(alert, animated: true, completion: nil)
            
        default:
            break
        }
    }
}

