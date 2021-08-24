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
        
        // MARK: StatementBusinessLogic
        func fetchStatement() {
            worker.fetchStatement { response in
                
            }
        }
    }
}

