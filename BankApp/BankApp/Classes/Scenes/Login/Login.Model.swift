//
//  Login.Model.swift
//  BankApp
//
//  Created by Vinicius Teixeira.
//

extension Login {
    
    struct Request: Encodable {
        
        let user: String
        let password: String
        
    }
    
    struct Response {
        
    }
}
