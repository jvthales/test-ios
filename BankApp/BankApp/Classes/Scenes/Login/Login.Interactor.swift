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
        var worker = Login.Worker()
        var presenter: LoginPresentationLogic?
        
        // MARK: LoginBusinessLogic
        func doLogin(request: Login.Request) {
            guard !request.user.isEmpty && !request.password.isEmpty else {
                presenter?.presentAlert(message: "Preencha os campos para prosseguir.")
                return
            }
            
            worker.doLogin(request: request) { response in
                response ? self.presenter?.presentToStatement() : self.presenter?.presentAlert(message: "Login inválido!")
            }
        }
    }
}
