//
//  Statement.Interactor.swift
//  BankApp
//
//  Created by Vinicius Teixeira.
//

protocol StatementBusinessLogic {
    func fetchStatement()
}

extension Statement {
    
    class Interactor: StatementBusinessLogic {
    
        // MARK: Properties
        var worker = Statement.Worker()
        var presenter: StatementPresentationLogic?
        
        // MARK: StatementBusinessLogic
        func fetchStatement() {
            worker.fetchStatement { response in
                self.presenter?.presentFetchedStatements(response: response)
            }
        }
    }
}

