//
//  Statement.ViewController.swift
//  BankApp
//
//  Created by Vinicius Teixeira.
//

import UIKit

protocol StatementDisplayLogic: AnyObject {
    func displayFetchedStatements(viewModel: Statement.ViewModel)
}

// MARK: - ViewController
public extension Statement {
    
    class MainViewController: UIViewController, StatementDisplayLogic {
        
        // MARK: Components
        lazy var myView = View()
        
        // MARK: Properties
        var interactor: StatementBusinessLogic?
        var router: StatementRoutingLogic?
        
        // MARK: Methods
        private func setup() {
            let viewController = self
            let interactor = Statement.Interactor()
            let presenter = Statement.Presenter()
            let router = Statement.Router()
            viewController.interactor = interactor
            viewController.router = router
            presenter.viewController = viewController
            interactor.presenter = presenter
            router.viewController = viewController
            
            myView.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        }
        
        // MARK: UIViewController
        public override func loadView() {
            view = myView
        }
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            setup()
        }
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            interactor?.fetchStatement()
        }
        
        // MARK: Actions
        @objc
        func backButtonTapped() {
            router?.routeToLogin()
        }
        
        // MARK: StatementDisplayLogic
        func displayFetchedStatements(viewModel: Statement.ViewModel) {
            myView.displayedStatements = viewModel.displayedStatements
        }
    }
}

// MARK: - View
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
        private let tableView: UITableView = {
            let tableView = UITableView()
            tableView.register(Cell.self)
            tableView.separatorStyle = .none
            return tableView
        }()
        
        // MARK: Properties
        var displayedStatements: [Statement.ViewModel.DisplayStatement] = [] {
            didSet { tableView.reloadData() }
        }
        
        // MARK: Initializers
        init() {
            super.init(frame: .zero)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: Methods
        func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
            header.addTarget(target, action: action, for: controlEvents)
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
            backgroundColor = .clear
            
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
}

// MARK: - View+UITableViewDataSource&UITableViewDelegate
extension Statement.MainViewController.View: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedStatements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let statement = displayedStatements[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(Cell.self, for: indexPath)
        cell.headerText = statement.type
        cell.dateText = statement.date
        cell.descriptionText = statement.detail
        cell.valueText = statement.value
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Recentes"
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor.hexString(hex: "#485465")
        
        let stackView = UIStackView()
        stackView.layoutMargins = .init(top: 14, left: 18, bottom: 14, right: 18)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.addArrangedSubview(label)
        return stackView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}

// MARK: - Cell
extension Statement.MainViewController.View {
    
    class Cell: UITableViewCell, CodeView {
        
        // MARK: Components
        private let contentStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 14
            stackView.layoutMargins = .init(top: 14, left: 14, bottom: 14, right: 14)
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        private lazy var headerStackView = UIStackView(arrangedSubviews: [headerLabel, UIView(), dateLabel])
        private let headerLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor.hexString(hex: "#A8B4C4")
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        
        private let dateLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor.hexString(hex: "#A8B4C4")
            label.font = .systemFont(ofSize: 12)
            return label
        }()
        
        private lazy var bottomStackView = UIStackView(arrangedSubviews: [descriptionLabel, UIView(), valueLabel])
        private let descriptionLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor.hexString(hex: "#485465")
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        
        private let valueLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor.hexString(hex: "#485465")
            label.font = .systemFont(ofSize: 20)
            return label
        }()
        
        private let shapeView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 6
            view.clipsToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        // MARK: Properties
        var headerText: String {
            get { headerLabel.text ?? "" }
            set { headerLabel.text = newValue }
        }
        
        var dateText: String {
            get { dateLabel.text ?? "" }
            set { dateLabel.text = newValue }
        }
        
        var descriptionText: String {
            get { descriptionLabel.text ?? "" }
            set { descriptionLabel.text = newValue }
        }
        
        var valueText: String {
            get { valueLabel.text ?? "" }
            set { valueLabel.text = newValue }
        }
        
        // MARK: Initializers
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: CodeView
        func buildViewHierarchy() {
            contentStackView.addArrangedSubview(headerStackView)
            contentStackView.addArrangedSubview(bottomStackView)
            shapeView.addSubview(contentStackView)
            contentView.addSubview(shapeView)
            contentView.addSubview(contentStackView)
        }
        
        func setupConstraints() {
            NSLayoutConstraint.activate([
                shapeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                shapeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                shapeView.topAnchor.constraint(equalTo: contentView.topAnchor),
                shapeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                shapeView.heightAnchor.constraint(equalToConstant: 80),

                contentStackView.leadingAnchor.constraint(equalTo: shapeView.leadingAnchor),
                contentStackView.trailingAnchor.constraint(equalTo: shapeView.trailingAnchor),
                contentStackView.topAnchor.constraint(equalTo: shapeView.topAnchor),
                contentStackView.bottomAnchor.constraint(equalTo: shapeView.bottomAnchor)
            ])
        }
        
        func setupAdditionalConfigurations() {
            contentView.backgroundColor = .clear
            backgroundColor = .clear
            
            shapeView.layer.borderWidth = 1
            shapeView.layer.borderColor = UIColor.hexString(hex: "#DBDFE3").withAlphaComponent(0.3).cgColor
            shapeView.addShadow(offset: .init(width: 0, height: 5), color: UIColor.hexString(hex: "#D9E2E9"), radius: 12, opacity: 0.5)
        }
    }
}

// MARK: - Header
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
        
        // MARK: Initializers
        init() {
            super.init(frame: .zero)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: Methods
        func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
            button.addTarget(target, action: action, for: controlEvents)
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


