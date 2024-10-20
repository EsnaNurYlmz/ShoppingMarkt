//
//  SignInViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 16.10.2024.
//

import UIKit
import CoreData

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SignInButton(_ sender: UIButton) {
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
               if let user = users.first {
                   if let userName = user.value(forKey: "name") as? String {
                       print("Kullanıcı adı başarıyla alındı: \(userName)") // Bu satırı ekleyerek kullanıcı adını kontrol edelim
                       UserDefaults.standard.set(userName, forKey: "userName")
                       UserDefaults.standard.synchronize() // Verinin hemen kaydedildiğinden emin ol
                       print("Kullanıcı adı UserDefaults'a kaydedildi: \(userName)") // Kaydedildiğini kontrol edelim
                   }
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
                // Ana menüye geçerken kullanıcı adını ilet
                                self.performSegue(withIdentifier: "goToHome", sender: self)

                // TextField'ları temizle
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
            }
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func SignUpButton(_ sender: Any) {
        performSegue(withIdentifier: "toSignUp" , sender: nil)
    }
   
    
}
