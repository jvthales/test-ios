//
//  Statement.Presenter.swift
//  Alamofire
//
//  Created by Vinicius Teixeira.
//

protocol StatementPresentationLogic {
  func presentFetchedStatements(response: Statement.Response)
}

extension Statement {
    
    class Presenter: StatementPresentationLogic {
        
        // MARK: Properties
        weak var viewController: StatementDisplayLogic?
        
        // MARK: StatementPresentationLogic
        func presentFetchedStatements(response: Statement.Response) {
            var displayedStatements: [Statement.ViewModel.DisplayStatement] = []
            response.statement.forEach {
                displayedStatements.append(.init(
                    id: $0.id,
                    type: $0.type,
                    date: $0.date.getDateFormatted(),
                    detail: $0.detail,
                    value: $0.value.toMoneyString(symbol: "R$"))
                )
            }
            viewController?.displayFetchedStatements(viewModel: .init(displayedStatements: displayedStatements))
        }
    }
}
