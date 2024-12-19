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
        guard let tokenData = token.data(using: .utf8) else {
            print("Error")
            return
        }
        
        let query : [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : "token",
            kSecValueData as String : tokenData
        ]
        
        SecItemDelete(query as CFDictionary)
        
        SecItemAdd(query as CFDictionary, nil)
    }
    
    static func getTokenFromKeychain() -> String? {
        let query : [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : "token",
            kSecReturnData as String : true
        ]
        
        var item : CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
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
