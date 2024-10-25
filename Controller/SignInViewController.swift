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
    var viewModel = SignInViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SignInButton(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
                      let password = passwordTextField.text, !password.isEmpty else {
                    showAlert(title: "Hata", message: "Lütfen tüm alanları doldurun")
                    return
                }
                // ViewModel'deki email ve password değerlerini ayarla
                viewModel.email = email
                viewModel.password = password
                
                // Kullanıcı doğrulama işlemi
                if viewModel.authenticateUser() {
                    // TabBarController ile ana sayfaya geçiş
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarControllerID") as? UITabBarController {
                        tabBarVC.modalPresentationStyle = .fullScreen
                        self.present(tabBarVC, animated: true, completion: nil)
                    }
                } else {
                    showAlert(title: "Hata", message: "Geçersiz kullanıcı adı veya şifre")
                }
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
