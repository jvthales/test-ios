//
//  CodeView.swift
//  BankApp
//
//  Created by Vinicius Teixeira.
//

public protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfigurations()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfigurations()
    }
}
