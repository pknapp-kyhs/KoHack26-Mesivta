//ChatGPT

import CryptoKit
import Foundation

// the CryptoKit library to hash the password
func hashPassword(_ password: String) -> String {
    let data = Data(password.utf8)
    let hash = SHA256.hash(data: data)
    //Iterates through the hash and makes it a string
    return hash.compactMap { String(format: "%02x", $0) }.joined()
}


