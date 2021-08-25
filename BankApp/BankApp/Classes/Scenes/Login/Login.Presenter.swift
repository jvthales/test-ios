//
//  Login.Presenter.swift
//  BankApp
//
//  Created by Vinicius Teixeira.
//

protocol LoginPresentationLogic {
    func presentToStatement()
    func presentAlert(message: String)
}

extension Login {
    
    class Presenter: LoginPresentationLogic {
        
        // MARK: Properties
        weak var viewController: LoginDisplayLogic?
        
        // MARK: LoginPresentationLogic
        func presentToStatement() {
            viewController?.displayStatement()
        }
        
        func presentAlert(message: String) {
            viewController?.displayAlert(message: message)
        }
    }
}
