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
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            fetchRequest.predicate = NSPredicate(format: "name == %@ OR email == %@", name, email)
        
        do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    showAlert(title: "Hata", message: "Bu isimde veya e-postada bir kullanıcı zaten var")
                    return
                }
                let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
                let newUser = NSManagedObject(entity: entity, insertInto: context)
                
                newUser.setValue(name, forKey: "name")
                newUser.setValue(email, forKey: "email")
                newUser.setValue(password, forKey: "password")
                
                try context.save()
                showAlert(title: "Başarılı", message: "Kullanıcı başarıyla kaydedildi")
                
            } catch {
                showAlert(title: "Hata", message: "Kullanıcı kaydedilemedi: \(error.localizedDescription)")
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
