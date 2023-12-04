//
//  ViewController.swift
//  FirebaseTesting
//
//  Created by Suguru Tokuda on 12/4/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseAuthUI
import FirebaseEmailAuthUI
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseOAuthUI

class ViewController: UIViewController, FUIAuthDelegate {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Firebase Signin"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        return label
    }()
    
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.placeholder = "Email"
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.keyboardType = .default
        textField.autocapitalizationType = .none
        textField.placeholder = "Password"
        return textField
    }()
    
    var signUpBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn.setTitleColor(.label, for: .normal)
        btn.layer.borderColor = UIColor.systemBlue.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.layer.backgroundColor = UIColor.systemBlue.cgColor
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.setTitle("Sign Up", for: .normal)
        
        return btn
    }()
    
    var signInBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn.setTitleColor(.label, for: .normal)
        btn.layer.borderColor = UIColor.systemBlue.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.layer.backgroundColor = UIColor.systemBlue.cgColor
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.setTitle("Sign In", for: .normal)
        
        return btn
    }()
    
    var fieldStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension ViewController {
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(fieldStackView)
        
//        fieldStackView.addArrangedSubview(emailTextField)
//        fieldStackView.addArrangedSubview(passwordTextField)
        fieldStackView.addArrangedSubview(signUpBtn)
        fieldStackView.addArrangedSubview(signInBtn)
        
        addEventHandlers()
        applyConstraints()
    }
    
    func addEventHandlers() {
        signUpBtn.addTarget(self, action: #selector(handleSignUpBtnTap), for: .touchUpInside)
        signInBtn.addTarget(self, action: #selector(handleSignInBtnTap), for: .touchUpInside)
    }
    
    
    func applyConstraints() {
        let titleLabelConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.2)
        ]
        
        let fieldStackViewConstraints = [
            fieldStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            fieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            fieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(fieldStackViewConstraints)
    }
}

extension ViewController {
    @objc func handleSignUpBtnTap() {
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://fir-testing-bd230.firebaseapp.com")
        actionCodeSettings.handleCodeInApp = true

        let provider = FUIEmailAuth(authAuthUI: FUIAuth.defaultAuthUI()!,
                                    signInMethod: GoogleAuthSignInMethod,
                                    forceSameDevice: false,
                                    allowNewEmailAccounts: true,
                                    actionCodeSetting: actionCodeSettings)
        
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        authUI?.providers = [provider]
        
        if let authVC = authUI?.authViewController() {
            self.present(authVC, animated: true)
        }
    }
    
    @objc func handleSignInBtnTap() {
        guard let authUI = FUIAuth.defaultAuthUI() else { return }

        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(authUI: authUI)
        ]
        
        authUI.delegate = self
        authUI.providers = providers
        
        let authVC = authUI.authViewController()
        self.present(authVC, animated: true)
    }
        
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        print(user)
        let vc = SecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
