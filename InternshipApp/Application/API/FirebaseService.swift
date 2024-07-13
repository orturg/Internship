//
//  FirebaseService.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 07.07.2024.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth

class FirebaseService {
    static let shared = FirebaseService()
    private init() {
        if let savedId = UserDefaults.standard.string(forKey: "userId") {
            id = savedId
        }
    }
    
    var id: String = ""
    let collection = Firestore.firestore().collection(TextValues.users)
    
    func createUser(userName: String, email: String, password: String, completion: @escaping (Result<String?, DataBaseError>) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password)
        
        id = collection.document().documentID
        
        UserDefaults.standard.set(self.id, forKey: TextValues.userId)
        
        collection.document(id).setData([
            "userName": userName,
            "email": email,
            "id": id
        ]) { error in
            if let error {
                completion(.failure(.errorCreatingUser))
            } else {
                completion(.success(nil))
            }
        }
    }
    
    
    func updateUser(with sex: String, completion: @escaping (Result<String?, DataBaseError>) -> Void) {
        collection.document(id).updateData([
            "sex": sex
        ]) { error in
            if let error {
                completion(.failure(.errorUpdatingUser))
            } else {
                completion(.success(nil))
            }
        }
    }
    
    
    func getUser(completion: @escaping (Result<RegistrationData?, DataBaseError>) -> Void) {
        collection.document(id).getDocument { documentSnapshot, error in
            if let error {
                completion(.failure(.errorGettingUser))
                return
            }
            
            guard let documentSnapshot = documentSnapshot, documentSnapshot.exists else {
                completion(.failure(.errorGettingUser))
                return
            }
            
            if let data = documentSnapshot.data() {
                let user = RegistrationData(
                    userName: data["userName"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    sex: data["sex"] as? String ?? "",
                    password: "",
                    id: data["id"] as? String ?? ""
                )
                completion(.success(user))
            } else {
                completion(.failure(.errorGettingUser))
            }
        }
    }
    
    
    func isUserCreated() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    
    func logOut() throws {
        try Auth.auth().signOut()
        UserDefaults.standard.set("", forKey: TextValues.userId)
    }
    
    
    func isAppDeleted() -> Bool {
        UserDefaults.standard.string(forKey: TextValues.userId) == nil
    }
}
