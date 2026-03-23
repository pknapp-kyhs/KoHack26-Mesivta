//
//  Firebase.swift
//  KoHack26
//
//  Created by Mendel W on 3/23/26.
//

import Foundation
import Firebase
import FirebaseFirestore

//apporpriate use of class 
public class fBaseAPI {
    
    //class methods
    
    //Code Handoff between more than one language/backend-frontend
    
    func writeToFB(text: String, filename: String, document: String){
        let db = Firestore.firestore()
        
        db.collection("myData").document(document).setData([
            filename: text
        ])
    }
    
    //Function that takes and returns parameters
    func readFromFB(filename: String, document: String,  completion: @escaping ([String]) -> Void) {
        let db = Firestore.firestore()
        
        //REST
        db.collection("myData").document(document).getDocument { snapshot, _ in
            let text = snapshot?.data()?[filename] as? String ?? ""
            let lines = text.components(separatedBy: "\n")
            completion(lines)
        }
    }
}
