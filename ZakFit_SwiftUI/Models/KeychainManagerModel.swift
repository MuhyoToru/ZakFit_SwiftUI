//
//  KeychainManager.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import Foundation
import Security

struct KeychainManager {
    static func saveTokenToKeychain(token: String) {
        //Convertir le token en data
        guard let tokenData = token.data(using: .utf8) else {
            print("Error")
            return
        }
        
        //Créer un dictionnaire de requête pour le trousseau (Keychain)
        let query : [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : "token",
            kSecValueData as String : tokenData
        ]
        
        //Supprimer la clef existante
        SecItemDelete(query as CFDictionary)
        
        //Ajouter le token dans le trousseau
        SecItemAdd(query as CFDictionary, nil)
    }
    
    static func getTokenFromKeychain() -> String? {
        //Créer un dictionnaire de requête pour le trousseau (Keychain)
        let query : [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : "token",
            kSecReturnData as String : true
        ]
        
        //Rechercher l'élément dans le Keychain
        var item : CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        //Décoder les informations en String
        if status == errSecSuccess, let data = item as? Data {
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }
    
    static func deleteTokenFromKeychain() {
        let query : [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : "token",
            kSecReturnData as String : true
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
