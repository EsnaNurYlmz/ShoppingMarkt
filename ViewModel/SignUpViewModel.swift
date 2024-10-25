//
//  SignUpViewModel.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 25.10.2024.
//

import Foundation
import CoreData
import UIKit

class SignUpViewModel {
    
    // Kayıt ekranı verileri
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var againPassword: String = ""

    // Kullanıcı kaydetme işlemi
    func saveUser(completion: @escaping (Bool, String) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(false, "Uygulama delegesine erişilemiyor")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "name == %@ OR email == %@", name, email)
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                completion(false, "Bu isimde veya e-postada bir kullanıcı zaten var")
                return
            }
            
            let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
            let newUser = NSManagedObject(entity: entity, insertInto: context)
            
            newUser.setValue(name, forKey: "name")
            newUser.setValue(email, forKey: "email")
            newUser.setValue(password, forKey: "password")
            
            try context.save()
            completion(true, "Kullanıcı başarıyla kaydedildi")
            
        } catch {
            completion(false, "Kullanıcı kaydedilemedi: \(error.localizedDescription)")
        }
    }
}
