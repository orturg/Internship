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
    
    
    func updateUsername(name: String, completion: @escaping (Result<String?, DataBaseError>) -> Void) {
        collection.document(id).updateData([
            "userName": name
        ]) { error in
            if let error {
                completion(.failure(.errorUpdatingUser))
            } else {
                completion(.success(nil))
            }
        }
    }
    
    
    func updateAvatar(image: UIImage, completion: @escaping (Result<String?, DataBaseError>) -> Void) {
        let imageData = image.compress(to: 1024)
        
        collection.document(id).updateData([
            "profileImage" : imageData
        ]) { error in
            if let error {
                completion(.failure(.errorUpdatingUser))
            } else {
                completion(.success(nil))
            }
        }
    }
    
    
    func updateOptionData(textFieldsDic: [[String: Any]], completion: @escaping (Result<String?, DataBaseError>) -> Void) {
        let docRef = collection.document(id)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var userOptions = document.data()?["userOptions"] as? [[String: Any]] ?? []
                var dataDic: [[String : Any]] = []
                
                textFieldsDic.forEach { cell in
                    
                    if let index = userOptions.firstIndex(where: { $0["optionName"] as? String == cell["optionName"] as? String }) {
                        
                        var valueArray = userOptions[index]["valueArray"] as? [Int] ?? []
                        var timeArray = userOptions[index]["dateArray"] as? [Double] ?? []
                        var isNewValue = false
                        
                        let currentTime = Date().timeIntervalSince1970
                        
                        let timeInterval = currentTime - timeArray[timeArray.count - 1]
                        let timeDifference = Int(timeInterval)
                        
                        if timeDifference > 60 { isNewValue = true }
                        
                        if let newValue = Int(cell["value"] as? String ?? "") {
                            if isNewValue {
                                timeArray.append(currentTime)
                                valueArray.append(newValue)
                            } else {
                                timeArray[timeArray.count - 1] = currentTime
                                valueArray[valueArray.count - 1] = newValue
                            }
                            
                            dataDic.append([
                                "optionName": userOptions[index]["optionName"],
                                "valueArray": valueArray,
                                "isShown": cell["isShown"],
                                "changedValue": valueArray.count == 1 ? 0 : valueArray[valueArray.count - 1] - valueArray[valueArray.count - 2],
                                "dateArray": timeArray
                            ])
                            print(dataDic)
                        }
                    } else {
                        var valueArray: [Int] = []
                        var timeArray: [Double] = []
                        
                        if let newValue = Int(cell["value"] as? String ?? "") {
                            valueArray.append(newValue)
                        }
                        timeArray.append(Date().timeIntervalSince1970)
                        
                        dataDic.append([
                            "optionName": cell["optionName"] as? String,
                            "valueArray": valueArray,
                            "isShown": cell["isShown"],
                            "changedValue": 0,
                            "dateArray": timeArray
                        ])
                    }
                }
                
                let data: [String: Any] = ["userOptions": dataDic]
                
                docRef.updateData(data) { error in
                    if let error = error {
                        completion(.failure(.errorUpdatingUser))
                    } else {
                        completion(.success(nil))
                    }
                }
            } else {
                completion(.failure(.errorGettingUser))
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
                    id: data["id"] as? String ?? "",
                    profileImage: data["profileImage"] as? Data ?? Data()
                )
                completion(.success(user))
            } else {
                completion(.failure(.errorGettingUser))
            }
        }
    }
    
    
    func getOptionData(completion: @escaping (Result<[OptionData]?, DataBaseError>) -> Void) {
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
            
            if let optionsData = documentSnapshot.get("userOptions") as? [[String: Any]] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: optionsData, options: [])
                    let userOptions = try JSONDecoder().decode([OptionData].self, from: jsonData)
                    completion(.success(userOptions))
                } catch {
                    completion(.failure(.errorGettingUser))
                }
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
    
    
    func getImage(completion: @escaping (Result<UIImage, DataBaseError>) -> Void) {
        getUser { result in
            switch result {
            case .success(let user):
                guard let user else { return }
                if let imageData = user.profileImage {
                    if let image = UIImage(data: imageData) {
                        completion(.success(image))
                    } else {
                        completion(.failure(.errorGettingUser))
                    }
                } else {
                    completion(.failure(.errorGettingUser))
                }
            case .failure(_):
                completion(.failure(.errorGettingUser))
            }
        }
    }
}
