//
//  AccountViewModel.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 25.10.2024.
//

import Foundation
import CoreData
import UIKit

class AccountViewModel {
    var loggedInUserEmail: String?
    var userName: String = " "
    let accountCategory = ["GİRİŞ", "ÜYELİK", "FAVORİLER", "SEPET", "ÇIKIŞ", "HESABI SİL"]
    
    // Kullanıcı adını çekme fonksiyonu
    func fetchUserName() {
        if let email = UserDefaults.standard.string(forKey: "loggedInUserEmail") {
            self.loggedInUserEmail = email
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            
            do {
                let results = try context.fetch(fetchRequest)
                if let user = results.first as? NSManagedObject, let name = user.value(forKey: "name") as? String {
                    self.userName = name
                }
            } catch {
                print("Kullanıcı adı çekme hatası: \(error.localizedDescription)")
            }
        }
    }

    // Kullanıcıyı silme fonksiyonu
    func deleteUser() {
        if let email = loggedInUserEmail {
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
                    UserDefaults.standard.removeObject(forKey: "loggedInUserEmail")
                    self.userName = "kullanıcı adı"
                }
            } catch {
                print("Kullanıcı silme hatası: \(error.localizedDescription)")
            }
        }
    }

    // Çıkış yapma işlemi
    func logOut() {
        UserDefaults.standard.removeObject(forKey: "loggedInUserEmail")
        self.userName = "kullanıcı adı"
        print("ÇIKIŞ yapılıyor...")
    }
    
    // Kategori başlıklarını almak
    func getCategory(at index: Int) -> String {
        return accountCategory[index]
    }
    
    // Kategori sayısını almak
    func getCategoryCount() -> Int {
        return accountCategory.count
    }
}
