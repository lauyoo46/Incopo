//
//  PersistanceManager.swift
//  Incopo
//
//  Created by Laurentiu Ile on 10.02.2021.
//

import Foundation
import Firebase

class FirestoreManager {
    
    static let shared = Firestore.firestore()
    
    private init() {}
}
