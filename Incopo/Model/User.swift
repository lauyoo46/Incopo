//
//  User.swift
//  Incopo
//
//  Created by Laurentiu Ile on 10.02.2021.
//

import UIKit

class User {

    let email: String
    let firstName: String
    let lastName: String
    let password: String
    let recents: [String]
    let profilePicture: UIImage
    
    init(email: String, firstName: String, lastName: String, password: String, recents: [String], profilePicture: UIImage) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.recents = recents
        self.profilePicture = profilePicture
    }
}
