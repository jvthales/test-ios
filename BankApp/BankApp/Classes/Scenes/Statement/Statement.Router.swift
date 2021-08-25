//
//  Statement.Router.swift
//  Alamofire
//
//  Created by Vinicius Teixeira.
//

protocol StatementRoutingLogic {
    func routeToLogin()
}

public extension Statement {

    class Router: NSObject, StatementRoutingLogic {

        // MARK: Properties
        weak var viewController: Statement.MainViewController?

        // MARK: LoginRoutingLogic
        func routeToLogin() {
            viewController?.navigationController?.popViewController(animated: true)
        }
    }
}
