//
//  Login.Router.swift
//  BankApp
//
//  Created by Vinicius Teixeira.
//

protocol LoginRoutingLogic {
    func routeToStatement()
    func routeToAlert(message: String)
}

extension Login {
    
    class Router: NSObject, LoginRoutingLogic {
    
        // MARK: Properties
        weak var viewController: Login.ViewController?
        
        // MARK: LoginRoutingLogic
        func routeToStatement() {
            let statementViewController = Statement.MainViewController()
            viewController?.navigationController?.pushViewController(statementViewController, animated: true)
        }
        
        func routeToAlert(message: String) {
            let alertController = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
}

