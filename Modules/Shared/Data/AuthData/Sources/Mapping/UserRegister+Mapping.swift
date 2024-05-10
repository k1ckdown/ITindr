//
//  UserRegister+Mapping.swift
//  AuthData
//
//  Created by Ivan Semenov on 10.05.2024.
//

import AuthDomain

extension UserRegister {
    
    func toDto() -> UserRegisterDTO {
        UserRegisterDTO(email: email, password: password)
    }
}
