//
//  Login.Router.swift
//  BankApp
//
//  Created by Vinicius Teixeira.
//

protocol LoginRoutingLogic {
    func routeToStatement()
}

extension Login {
    
    class Router: NSObject, LoginRoutingLogic {
    
        // MARK: Properties
        weak var viewController: Login.ViewController?
        
        // MARK: LoginRoutingLogic
        func routeToStatement() {
            
        }
        
    }
}

