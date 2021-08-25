//
//  Login.ViewController.swift
//  BankApp
//
//  Created by Vinicius Teixeira.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    func displayStatement()
    func displayAlert(message: String)
}

// MARK: - ViewController
public extension Login {
    
    class ViewController: UIViewController, LoginDisplayLogic {
        
        // MARK: Components
        lazy var myView = View()
        
        // MARK: Properties
        var router: Login.Router?
        var interactor: LoginBusinessLogic?
        
        // MARK: Methods
        private func setup() {
            let viewController = self
            let interactor = Login.Interactor()
            let presenter = Login.Presenter()
            let router = Login.Router()
            viewController.interactor = interactor
            viewController.router = router
            presenter.viewController = viewController
            interactor.presenter = presenter
            router.viewController = viewController
            
            myView.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        }
        
        // MARK: UIViewController
        public override func loadView() {
            view = myView
        }
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            
            setup()
        }
        
        // MARK: Actions
        @objc
        private func loginButtonTapped() {
            interactor?.doLogin(request: .init(user: myView.user, password: myView.password))
        }
        
        // MARK: LoginDisplayLogic
        func displayStatement() {
            router?.routeToStatement()
        }
        
        func displayAlert(message: String) {
            router?.routeToAlert(message: message)
        }
    }
}

// MARK: - View
extension Login.ViewController {
    
    class View: UIView, CodeView {
        
        // MARK: Components
        private let contentStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.layoutMargins = .init(top: 36, left: 17, bottom: 42, right: 16)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.isLayoutMarginsRelativeArrangement = true
            return stackView
        }()
        
        private var imageView = UIImageView(image: ImageManager.get("logo"))
        
        private let loginTextField: TextField = {
            let textField = TextField()
            textField.placeholder = "User"
            return textField
        }()
        
        private let passwordTextField: TextField = {
            let textField = TextField()
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            return textField
        }()
        
        private let button: UIButton = {
            let button = UIButton()
            button.setTitle("Login", for: .normal)
            button.backgroundColor = UIColor.hexString(hex: "#3B48EE")
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        private let buttonStackView = UIStackView()
        
        // MARK: Properties
        public var user: String {
            get { loginTextField.text ?? "" }
            set { loginTextField.text = newValue }
        }
        
        public var password: String {
            get { passwordTextField.text ?? "" }
            set { passwordTextField.text = newValue }
        }
        
        // MARK: Initializers
        init() {
            super.init(frame: .zero)
            
            setupView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: Actions
        public func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
            button.addTarget(target, action: action, for: controlEvents)
        }
        
        // MARK: CodeView
        public func buildViewHierarchy() {
            contentStackView.addArrangedSubview(imageView)
            contentStackView.setCustomSpacing(105, after: imageView)
            contentStackView.addArrangedSubview(loginTextField)
            contentStackView.setCustomSpacing(21, after: loginTextField)
            contentStackView.addArrangedSubview(passwordTextField)
            contentStackView.setCustomSpacing(220, after: passwordTextField)
            
            buttonStackView.addArrangedSubview(button)
            contentStackView.addArrangedSubview(buttonStackView)
            
            addSubview(contentStackView)
        }
        
        public func setupConstraints() {
            NSLayoutConstraint.activate([
                contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                contentStackView.topAnchor.constraint(equalTo: topAnchor),
                contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                button.widthAnchor.constraint(equalToConstant: 190),
                button.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        
        public func setupAdditionalConfigurations() {
            backgroundColor = .white
            imageView.contentMode = .scaleAspectFit
            
            buttonStackView.axis = .vertical
            buttonStackView.alignment = .center
            
            button.layer.cornerRadius = 4
        }
    }
}

// MARK: - TextField
extension Login.ViewController.View {
    
    class TextField: UITextField, CodeView {
        
        // MARK: Properties
        let padding = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
        
        // MARK: Initializers
        init() {
            super.init(frame: .zero)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: UIView
        override open func textRect(forBounds bounds: CGRect) -> CGRect {
            return UIEdgeInsetsInsetRect(bounds, padding)
        }

        override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return UIEdgeInsetsInsetRect(bounds, padding)
        }

        override open func editingRect(forBounds bounds: CGRect) -> CGRect {
            return UIEdgeInsetsInsetRect(bounds, padding)
        }
        
        // MARK: CodeView
        func buildViewHierarchy() {}
        
        func setupConstraints() {
            NSLayoutConstraint.activate([heightAnchor.constraint(equalToConstant: 50)])
        }
        
        func setupAdditionalConfigurations() {
            layer.cornerRadius = 4
            layer.borderWidth = 1
            layer.borderColor = UIColor.hexString(hex: "#DCE2EE").cgColor
        }
    }
}
