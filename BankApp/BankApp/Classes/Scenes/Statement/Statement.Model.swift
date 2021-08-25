//
//  Statement.Model.swift
//  BankApp
//
//  Created by Vinicius Teixeira.
//

extension Statement {
    
    struct Response: Decodable {
        
        let statement: [Info]
        
        struct Info: Decodable {
            
            let id: Int
            let type: String
            let date: String
            let detail: String
            let value: Double
            
        }
    }
    
    struct ViewModel {
        
        var displayedStatements: [DisplayStatement]
        
        struct DisplayStatement {
            let id: Int
            let type: String
            let date: String
            let detail: String
            let value: String
        }
    }
}
