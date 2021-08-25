//
//  Login.Worker.swift
//  BankApp
//
//  Created by Vinicius Teixeira.
//

extension Login {
    
    class Worker {
        
        // MARK: Methods
        func doLogin(request: Login.Request, completion: @escaping (Bool) -> Void) {
            if request.user == "test_user" && request.password == "Test@1" {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
