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
    private init() {  }
    
    var id: String = ""
    let collection = Firestore.firestore().collection(TextValues.users)
    
    func createUser(userName: String, email: String, password: String, completion: @escaping (Result<String?, DataBaseError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(.errorCreatingUser))
                return
            }
            
            guard let user = authResult?.user else {
                completion(.failure(.errorCreatingUser))
                return
            }
            
            self.id = user.uid
            UserDefaults.standard.set(self.id, forKey: TextValues.userId)
            
            self.collection.document(self.id).setData([
                "userName": userName,
                "email": email,
                "id": self.id
            ]) { error in
                if let error = error {
                    completion(.failure(.errorCreatingUser))
                } else {
                    completion(.success(nil))
                }
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
        guard let currentUser = Auth.auth().currentUser else {
            completion(.failure(.errorGettingUser))
            return
        }
        
        id = currentUser.uid
        
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

    
    func login(email: String, password: String, completion: @escaping(Result<String?, DataBaseError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            
            guard let self else { return }
            
            if let error {
                completion(.failure(.errorSigningIn))
            }
            
            guard let currentUser = Auth.auth().currentUser else {
                completion(.failure(.errorGettingUser))
                return
            }
            
            self.id = currentUser.uid
            completion(.success(nil))
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
    
    
    func resetPassword(email: String, completion: @escaping(Result<String?, DataBaseError>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error {
                completion(.failure(.errorResetingPassword))
            }
            completion(.success(nil))
        }
    }
}
