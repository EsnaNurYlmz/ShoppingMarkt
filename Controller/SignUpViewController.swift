//
//  SignUpViewController.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 3.10.2024.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var againPasswordTextField: UITextField!
    var viewModel = SignUpViewModel()
    
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
                // ViewModel'deki verileri güncelle
                viewModel.name = name
                viewModel.email = email
                viewModel.password = password
                viewModel.againPassword = againPassword
                
                // Kullanıcıyı kaydetme işlemi
                viewModel.saveUser { success, message in
                    if success {
                        self.showAlert(title: "Başarılı", message: message)
                    } else {
                        self.showAlert(title: "Hata", message: message)
                    }
                }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Tamam", style: .default) { _ in
                    if title == "Başarılı" {
                        // Formu sıfırla
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
