//
//  LocationRepository.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift


class UserRepository: ObservableObject {
  // Set up properties here
  private let path: String = "User"
  
  private let store = Firestore.firestore()
  
  @Published var user: [User] = []
  
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get()
  }

  func get() {
    // get user data
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting user: \(error.localizedDescription)")
          return
        }
        self.user = querySnapshot?.documents.compactMap { document in
          try? document.data(as: User.self)
        } ?? []
      }
  }
    
    func verify(userName:String, pwd:String) -> Bool{
        var isVerified = false
        for _user in user {
            if (_user.name == userName && _user.pwd == pwd) {
                isVerified = true
                print(_user.id)
                break
            }
        }
        return isVerified
    }
    
    func getUserId(userName:String) -> UUID {
        var userId = UUID()
        for _user in user {
            if (_user.name == userName) {
                userId = _user.id
                break
            }
        }
        return userId
    }
        
  
  // MARK: CRUD methods
//  func add(_ user: User) {
//    do {
//      let newUser = user
//      _ = try store.collection(path).document(newUser.id.uuidString).setData(from: newUser)
//    } catch {
//      fatalError("Unable to add user: \(error.localizedDescription).")
//    }
//  }
//
//  func update(_ user: User) {
//    do {
//      let id = user.id.uuidString
//      try store.collection(path).document(id).setData(from: user)
//    } catch {
//      fatalError("Unable to update user: \(error.localizedDescription).")
//    }
//  }
//
//  func remove(_ user: User) {
//    do {
//      let id = user.id.uuidString
//      store.collection(path).document(id).delete { error in
//        if let error = error {
//          print("Unable to remove user: \(error.localizedDescription)")
//        }
//      }
//    }
//  }
}

