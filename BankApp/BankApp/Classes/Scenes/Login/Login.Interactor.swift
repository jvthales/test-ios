//
//  Login.Interactor.swift
//  BankApp
//
//  Created by Vinicius Teixeira.
//

protocol LoginBusinessLogic {
    func doLogin(request: Login.Request)
}

extension Login {
    
    class Interactor: LoginBusinessLogic {
    
        // MARK: Properties
        var worker = LoginWorker()
        
        // MARK: LoginBusinessLogic
        func doLogin(request: Login.Request) {
            worker.doLogin(request: request) { response in
                
            }
        }
    }
}
