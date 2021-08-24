//
//  Statement.Worker.swift
//  BankApp
//
//  Created by Vinicius Teixeira.
//

import Alamofire

extension Statement {
    
    class Worker {
        
        // MARK: Methods
        func fetchStatement(completion: @escaping (Statement.Response) -> Void) {
            let headers: HTTPHeaders = [.contentType("application/x-www-form-urlencoded")]
            let request = AF.request("https://6092aef785ff5100172136c2.mockapi.io/api/statements/", method: .get, headers: headers)
            
            request.responseDecodable(of: Statement.Response.self) { (response) in
                guard let statement = response.value else { return }
                completion(statement)
            }
        }
    }
}
