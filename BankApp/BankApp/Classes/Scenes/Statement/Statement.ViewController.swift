//
//  Statement.ViewController.swift
//  BankApp
//
//  Created by Vinicius Teixeira.
//

import UIKit

public extension Statement {
    
    class MainViewController: UIViewController {
        
    }
}

extension Statement.MainViewController {
    
    class View: UIView, CodeView {
        
        // MARK: Components
        
        // MARK: Properties
        
        
        // MARK: CodeView
        func buildViewHierarchy() {
            
        }
        
        func setupConstraints() {
            
        }
        
        func setupAdditionalConfigurations() {
            
        }
    }
}

extension Statement.MainViewController.View {
    
    class Header: UIView, CodeView {
        
        // MARK: Components
        private let contentStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.layoutMargins = .init(top: 20, left: 18, bottom: 17, right: 13)
            stackView.isLayoutMarginsRelativeArrangement = true
            return stackView
        }()
        
        private let headerStackView = UIStackView()
        private let nameLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            return label
        }()
        
        private let accountLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            return label
        }()
        
        private let balanceLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            return label
        }()
        
        // MARK: Properties
        
        
        // MARK: CodeView
        func buildViewHierarchy() {
            addSubview(contentStackView)
        }
        
        func setupConstraints() {
            NSLayoutConstraint.activate([
                contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                contentStackView.topAnchor.constraint(equalTo: topAnchor),
                contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
        
        func setupAdditionalConfigurations() {
            backgroundColor = UIColor.hexString(hex: "#3B49EE")
        }
    }
}


