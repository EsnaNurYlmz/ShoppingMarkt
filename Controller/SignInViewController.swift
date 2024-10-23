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
                      let password = passwordTextField.text, !password.isEmpty else {
                    showAlert(title: "Hata", message: "Lütfen tüm alanları doldurun")
                    return
                }
                
                // Core Data'dan kullanıcı doğrulaması
                if authenticateUser(email: email, password: password) {
                    // UserDefaults ile kullanıcı oturumu açıldı
                    UserDefaults.standard.set(email, forKey: "loggedInUserEmail")
                    performSegue(withIdentifier: "goToAccountVC", sender: nil)
                } else {
                    showAlert(title: "Hata", message: "Geçersiz kullanıcı adı veya şifre")
                }
    }
    func authenticateUser(email: String, password: String) -> Bool {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    return true
                }
            } catch {
                print("Hata: \(error.localizedDescription)")
            }
            return false
        }
    func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    
    
    @IBAction func SignUpButton(_ sender: Any) {
        performSegue(withIdentifier: "toSignUp" , sender: nil)
    }
    
    
    
    
}

