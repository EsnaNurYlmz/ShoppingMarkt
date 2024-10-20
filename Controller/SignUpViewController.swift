//
//  SignUpViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 3.10.2024.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var againPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let againPassword = againPasswordTextField.text, !againPassword.isEmpty else {
            showAlert(title: "Hata", message: "Lütfen tüm alanları doldurun")
                    return
                }
                if password != againPassword {
                    showAlert(title: "Hata", message: "Şifreler eşleşmiyor")
                    return
                }
        saveUser(name : name, email: email, password: password)
    }
    func saveUser(name: String, email: String, password: String) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
            let newUser = NSManagedObject(entity: entity, insertInto: context)

            newUser.setValue(name, forKey: "name")
            newUser.setValue(email, forKey: "email")
            newUser.setValue(password, forKey: "password")

            do {
                try context.save()
                showAlert(title: "Başarılı", message: "Kullanıcı başarıyla kaydedildi")
            } catch {
                showAlert(title: "Hata", message: "Kullanıcı kaydedilemedi: \(error)")
            }
        }
    func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Tamam", style: .default) { _ in
                // "Tamam" butonuna basılınca yapılacaklar
                if title == "Başarılı" {
                    // Eğer başarılıysa, formu sıfırla
                    self.nameTextField.text = ""
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.againPasswordTextField.text = ""
                    
                    // İstersen kullanıcıyı giriş ekranına da yönlendirebilirsin
                     self.dismiss(animated: true, completion: nil)
                }
            }
            
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
}
/*
 giriş sayfası
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
*/
