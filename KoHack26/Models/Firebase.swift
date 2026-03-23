//
//  Firebase.swift
//  KoHack26
//
//  Created by Mendel W on 3/23/26.
//

import Foundation
import Firebase
import FirebaseFirestore

//Apporpriate use of class
public class fBaseAPI {
    let db = Firestore.firestore()
    //Class methods
    //Code Handoff between more than one language/backend-frontend
    
    func writeToFB(text: String, filename: String, document: String) {
        //Writes to the Firebase database
        
        db.collection("myData").document(document).setData([
            filename: text
        ])
    }
    
    //Function that takes and returns parameters
    func readFromFB(filename: String, document: String, completion: @escaping ([String]) -> Void) {
        //Reads from the firebase
        
        //REST
        db.collection("myData").document(document).getDocument { snapshot, _ in
            let text = snapshot?.data()?[filename] as? String ?? ""
            let lines = text.components(separatedBy: "\n")
            //Waits till the end so it has data
            completion(lines)
        }
    }
}
