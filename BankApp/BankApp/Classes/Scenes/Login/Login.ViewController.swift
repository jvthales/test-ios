//
//  Login.ViewController.swift
//  BankApp
//
//  Created by Vinicius Teixeira.
//

import UIKit

// MARK: - ViewController
public extension Login {
    
    class ViewController: UIViewController {
        
        // MARK: Components
        lazy var myView = View()
        
        // MARK: Properties
        var router: Login.Router?
        
        // MARK: Methods
        private func setup() {
            myView.interactor = Login.Interactor()
        }
        
        // MARK: UIViewController
        public override func loadView() {
            view = myView
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
        private var user: String {
            get { loginTextField.text ?? "" }
            set { loginTextField.text = newValue }
        }
        
        private var password: String {
            get { passwordTextField.text ?? "" }
            set { passwordTextField.text = newValue }
        }
        
        public var interactor: Login.Interactor?
        
        // MARK: Initializers
        init() {
            super.init(frame: .zero)
            
            setupView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: Actions
        @objc
        private func didButtonTap() {
            guard !user.isEmpty && !password.isEmpty else {
                let alertController = UIAlertController(title: "Atenção", message: "Preencha os campos de usuário e senha para prosseguir.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                alertController.present(animated: true, completion: nil)
                return
            }
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
            button.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
            
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
