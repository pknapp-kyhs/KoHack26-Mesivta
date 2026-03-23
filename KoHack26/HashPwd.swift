import CryptoKit
import Foundation

func hashPassword(_ password: String) -> String {
    let data = Data(password.utf8)
    let hash = SHA256.hash(data: data)
    return hash.compactMap { String(format: "%02x", $0) }.joined()
}


