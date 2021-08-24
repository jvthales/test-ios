//
//  Statement.ViewController.swift
//  BankApp
//
//  Created by Vinicius Teixeira.
//

import UIKit

public extension Statement {
    
    class MainViewController: UIViewController {
        
        // MARK: Components
        lazy var myView = View()
        
        // MARK: Properties
//        var router: Login.Router?
        
        // MARK: Methods
        private func setup() {
//            myView.interactor = Login.Interactor()
        }
        
        // MARK: UIViewController
        public override func loadView() {
            view = myView
        }
    }
}

extension Statement.MainViewController {
    
    class View: UIView, CodeView {
        
        // MARK: Components
        private let contentStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.insetsLayoutMarginsFromSafeArea = false
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        private let header = Header()
        private let tableView = UITableView()
        
        // MARK: Properties
        
        // MARK: Initializers
        init() {
            super.init(frame: .zero)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: CodeView
        func buildViewHierarchy() {
            contentStackView.addArrangedSubview(header)
            contentStackView.addArrangedSubview(tableView)
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
            backgroundColor = .white
            
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
}

extension Statement.MainViewController.View: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
            stackView.backgroundColor = .clear
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        private lazy var headerStackView = UIStackView(arrangedSubviews: [nameLabel, UIView(), button])
        private let nameLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.text = "Jose da Silva Teste"
            label.font = .systemFont(ofSize: 25)
            return label
        }()
        
        private let button: UIButton = {
            let button = UIButton()
            button.setImage(ImageManager.get("button"), for: .normal)
            return button
        }()
        
        private let accountDescripionLabel: UILabel = {
            let label = UILabel()
            label.text = "Conta"
            label.textColor = .white
            label.font = .systemFont(ofSize: 12)
            return label
        }()
        
        private let accountLabel: UILabel = {
            let label = UILabel()
            label.text = "2050 / 01.111222-4"
            label.textColor = .white
            return label
        }()
        
        private let balanceDescripionLabel: UILabel = {
            let label = UILabel()
            label.text = "Saldo"
            label.textColor = .white
            label.font = .systemFont(ofSize: 12)
            return label
        }()
        
        private let balanceLabel: UILabel = {
            let label = UILabel()
            label.text = "R$ 1.000,00"
            label.textColor = .white
            return label
        }()
        
        // MARK: Properties
        
        // MARK: Initializers
        init() {
            super.init(frame: .zero)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: CodeView
        func buildViewHierarchy() {
            contentStackView.addArrangedSubview(headerStackView)
            contentStackView.setCustomSpacing(28, after: headerStackView)
            contentStackView.addArrangedSubview(accountDescripionLabel)
            contentStackView.setCustomSpacing(6, after: accountDescripionLabel)
            contentStackView.addArrangedSubview(accountLabel)
            contentStackView.setCustomSpacing(21, after: accountLabel)
            contentStackView.addArrangedSubview(balanceDescripionLabel)
            contentStackView.setCustomSpacing(7, after: balanceDescripionLabel)
            contentStackView.addArrangedSubview(balanceLabel)
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


