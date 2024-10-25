//
//  SignInViewModel.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 25.10.2024.
//

import Foundation
import CoreData
import UIKit

class SignInViewModel {
    var email: String = ""
    var password: String = ""
    
    // Kullanıcı doğrulama fonksiyonu
    func authenticateUser() -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                // Kullanıcı doğrulandı
                UserDefaults.standard.set(email, forKey: "loggedInUserEmail")
                return true
            }
        } catch {
            print("Hata: \(error.localizedDescription)")
        }
        return false
    }
}
