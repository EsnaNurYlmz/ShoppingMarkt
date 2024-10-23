//
//  UserSession.swift
//  ShoppingMarkt
//
//  Created by Esna nur Yılmaz on 21.10.2024.
//

import Foundation

class UserSession {
    static let shared = UserSession()  // Singleton instance
    
    private init() {}  // Dışarıdan bu sınıfın bir instance'ı oluşturulamasın
    
    var loggedInEmail: String?  // Giriş yapan kullanıcının e-posta adresini saklayacak
}
