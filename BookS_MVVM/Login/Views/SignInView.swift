//
//  SingInView.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import UIKit

protocol SignInViewDelegate: AnyObject {
    func signInUser(username: String, password: String)
    func signUp()
}

class SignInView: UIView {
    weak var delegate: SignInViewDelegate?
    let titleLabel = UILabel()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let signUpButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    private func setupView() {

        backgroundColor = UIColor.systemBackground
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
        titleLabel.textAlignment = .center
        titleLabel.text = "Sign In"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            usernameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        usernameTextField.placeholder = "username"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.delegate = self
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        passwordTextField.placeholder = "password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            signUpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            signUpButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        signUpButton.setTitle("Registrarse", for: .normal)
        signUpButton.setTitleColor(UIColor.secondaryLabel, for: .normal)
        signUpButton.addTarget(self,
                               action: #selector(tapSignUp),
                               for: .touchUpInside)
        
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            loginButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.backgroundColor = UIColor.gray
        loginButton.layer.masksToBounds = true
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 4
        loginButton.isEnabled = false
        loginButton.addTarget(self, action: #selector(tapLogin), for: .touchUpInside)
    }
    
    @objc func tapSignUp() {
        delegate?.signUp()
    }
    
    @objc func tapLogin() {
        guard let username = usernameTextField.text,
              !username.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty else {
                  return
              }
        delegate?.signInUser(username: username,
                             password: password)
    }
    
    public func fieldsCompleted() -> Bool {
        guard let username = usernameTextField.text,
              !username.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty else {
                  return false
              }
        return true
    }
    
    private func isCompleted() {
        if fieldsCompleted() {
            loginButton.backgroundColor = UIColor.green
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = UIColor.gray
            loginButton.isEnabled = false
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignInView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        isCompleted()
        return true
    }
}

