//
//  AccountViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 16.09.2024.
//

import UIKit
import CoreData

class AccountViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !email.isEmpty
        else{
            print("Lütfen Tüm Alanları Doldurun!")
            return
        }
        if checkUserCredentials(email:email , password:password){
            print("Giriş Başarılı")
            showAlert(title: "Başarılı", message: "Giriş yapıldı!")
            
        }
        else{
            print("Geçersiz E-Posta veya Şifre")
            showAlert(title: "Hata", message: "Geçersiz E-Posta veya Şifre")
        }
    }
    
    func checkUserCredentials(email:String, password:String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else{
            return false
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
                fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        do {
                   let users = try context.fetch(fetchRequest)
                   if users.count > 0 {
                       return true
                   } else {
                       return false
                   }
               } catch {
                   print("Kullanıcı Bulunamadı: \(error)")
                   return false
               }
           }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Tamam", style: .default) { _ in
            if title == "Başarılı" {
                // Ana menüyü içeren TabBarController'a geçiş yapalım
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarControllerID") as? UITabBarController {
                    tabBarVC.modalPresentationStyle = .fullScreen
                    self.present(tabBarVC, animated: true, completion: nil)
                }

                // TextField'ları temizle
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
            }
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignUp" , sender: nil)
    }
    
}
