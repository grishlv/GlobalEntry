////
////  LogInViewController.swift
////  GlobalEntry
////
////  Created by Grigoriy Shilyaev on 12.04.23.
//
//import Foundation
//import UIKit
//import SnapKit
//import Firebase
//import FirebaseCore
//import FirebaseAuth
//import FirebaseFirestore
//import GoogleSignIn
//
//final class LogInViewController: UIViewController, UITextFieldDelegate {
//    
//    private let presenterLogin: LoginInputProtocol
//    
//    //MARK: - header label
//    private lazy var labelHeader: UILabel = {
//        let labelHeader = UILabel()
//        labelHeader.text = "Login"
//        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
//        labelHeader.font = UIFont(name: "Inter-Bold", size: 26)
//        labelHeader.numberOfLines = 1
//        view.addSubview(labelHeader)
//        return labelHeader
//    }()
//    
//    //MARK: - textfield email address
//    private lazy var textFieldEmail: UITextField = {
//        let textFieldEmail = UITextField()
//        //add common style parameters
//        setupCommonStyleForTextFields(textFieldEmail)
//        textFieldEmail.textContentType = .emailAddress
//        textFieldEmail.keyboardType = .emailAddress
//        textFieldEmail.autocapitalizationType = .none
//        textFieldEmail.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 126/255, green: 131/255, blue: 137/255, alpha: 1)])
//        textFieldEmail.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldEmail.frame.height))
//        textFieldEmail.delegate = self
//        textFieldEmail.tag = 1
//        view.addSubview(textFieldEmail)
//        return textFieldEmail
//    }()
//    
//    //MARK: - textfield password
//    private lazy var textFieldPassword: UITextField = {
//        let textFieldPassword = UITextField()
//        //add common style parameters
//        setupCommonStyleForTextFields(textFieldPassword)
//        textFieldPassword.enablePasswordToggle()
//        textFieldPassword.textContentType = .password
//        textFieldPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 126/255, green: 131/255, blue: 137/255, alpha: 1)])
//        textFieldPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldPassword.frame.height))
//        textFieldPassword.delegate = self
//        textFieldPassword.tag = 2
//        textFieldPassword.isSecureTextEntry.toggle()
//        view.addSubview(textFieldPassword)
//        return textFieldPassword
//    }()
//    
//    //MARK: - log in button
//    private lazy var buttonLogIn: UIButton = {
//        let buttonLogIn = UIButton()
//        buttonLogIn.backgroundColor = UIColor(red: 43/255, green: 125/255, blue: 246/255, alpha: 1)
//        buttonLogIn.layer.cornerRadius = 10
//        buttonLogIn.setTitle("Login", for: .normal)
//        buttonLogIn.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)
//        view.addSubview(buttonLogIn)
//        return buttonLogIn
//    }()
//    
//    //MARK: - google auth button
//    private lazy var GIDSignInButton: UIButton = {
//        let GIDSignInButton = UIButton()
//        GIDSignInButton.leftImage(image: UIImage(named: "googleTitle")!, renderMode: .alwaysOriginal)
//        GIDSignInButton.backgroundColor = .white
//        GIDSignInButton.layer.cornerRadius = 10
//        GIDSignInButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
//        GIDSignInButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        GIDSignInButton.layer.shadowOpacity = 1.0
//        GIDSignInButton.layer.shadowRadius = 20
//        GIDSignInButton.layer.masksToBounds = false
//        view.addSubview(GIDSignInButton)
//        return GIDSignInButton
//    }()
//    
//    //MARK: - activity indicator
//    private lazy var spinner: UIActivityIndicatorView = {
//        let spinner = UIActivityIndicatorView(style: .large)
//        spinner.color = .gray
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(spinner)
//        return spinner
//    }()
//    
//    init(presenterLogin: LoginInputProtocol) {
//        self.presenterLogin = presenterLogin
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
//        
//        setupLabelHeader()
//        setupTextFieldEmail()
//        setupTextFieldPassword()
//        setupTapToHideKeyboard()
//        setupSpinner()
//        setupButtonLogIn()
//        setupButtonGoogle()
//    }
//    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
//    }
//    
//    //MARK: - label header
//    private func setupLabelHeader() {
//        
//        //constraints
//        labelHeader.snp.makeConstraints({ make in
//            make.top.equalToSuperview().inset(120)
//            make.leading.equalTo(textFieldEmail.snp.leading)
//            make.width.equalTo(220)
//            make.height.equalTo(35)
//        })
//    }
//    
//    //MARK: - text field name
//    private func setupTextFieldEmail() {
//        
//        //constraints
//        textFieldEmail.snp.makeConstraints({ make in
//            make.top.equalTo(labelHeader.snp.bottom).offset(16)
//            make.centerX.equalToSuperview()
//            make.width.equalTo(345)
//            make.height.equalTo(48)
//        })
//    }
//    
//    //MARK: - text field password
//    private func setupTextFieldPassword() {
//        
//        //constraints
//        textFieldPassword.snp.makeConstraints({ make in
//            make.top.equalTo(textFieldEmail.snp.bottom).offset(15)
//            make.centerX.equalToSuperview()
//            make.width.equalTo(345)
//            make.height.equalTo(48)
//        })
//    }
//    
//    //MARK: - button log in
//    func setupButtonLogIn() {
//        
//        //constraints
//        buttonLogIn.snp.makeConstraints( { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(textFieldPassword.snp.bottom).offset(40)
//            make.width.equalTo(335)
//            make.height.equalTo(48)
//        })
//        
//        //MARK: - create action on the next view
//        buttonLogIn.addTarget(self, action: #selector(actionForLogInButton), for: .touchUpInside)
//    }
//    
//    //MARK: - indicator activity view
//    func setupSpinner() {
//        
//        //constraints
//        spinner.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview().inset(-40)
//        }
//    }
//    
//    //MARK: - button google
//    private func setupButtonGoogle() {
//        
//        //constraints
//        GIDSignInButton.snp.makeConstraints( { make in
//            make.leading.equalTo(buttonLogIn.snp.leading)
//            make.top.equalTo(buttonLogIn.snp.bottom).offset(16)
//            make.width.equalTo(335)
//            make.height.equalTo(48)
//        })
//        
//        //MARK: - create action on the next view
//        GIDSignInButton.addTarget(self, action: #selector(actionForGoogleButton), for: .touchUpInside)
//    }
//    
//    private func showAlert(with text: String) {
//        let alertError = UIAlertController(title: "Login Failed", message: text, preferredStyle: .alert)
//        alertError.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alertError, animated: true)
//    }
//    
//    //MARK: - action to the next view
//    @objc func actionForLogInButton() {
//        
//        let isValid = validateFields()
//        
//        if isValid {
//            guard let email = textFieldEmail.text,
//                  let password = textFieldPassword.text else { return }
//            
//            let user = Login(email: email, password: password)
//            self.presenterLogin.loginWithUsername(user: user)
//        }
//    }
//    
//    //MARK: - action to the next view with google button
//    @objc func actionForGoogleButton() {
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//        
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//        
//        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
//            guard let result else { return }
//            self.presenterLogin.loginWithGoogle(with: result)
//        }
//    }
//    
//    func transitionNext() {
//        let viewModel = ChoosePassportViewModel()
//        let chooseVC = ChoosePassportViewController(viewModel: viewModel, tabBar: TabController())
//        spinner.startAnimating()
//        DispatchQueue.main.async {
//            self.navigationController?.pushViewController(chooseVC, animated: true)
//        }
//    }
//    
//    //MARK: - tap to hide keyboard from any point on view
//    private func setupTapToHideKeyboard() {
//        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
//        view.addGestureRecognizer(tap)
//    }
//}
//
////MARK: - text field improvements
//extension LogInViewController {
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        //try to find next responder
//        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
//            nextField.becomeFirstResponder()
//        } else {
//            //if not found then remove keyboard
//            textField.resignFirstResponder()
//        }
//        return false
//    }
//    
//    //MARK: - add common style functions for text fields
//    private func setupCommonStyleForTextFields(_ textField: UITextField) {
//        textField.leftViewMode = .always
//        textField.textColor = UIColor(red: 126/255, green: 131/255, blue: 137/255, alpha: 1)
//        textField.font = UIFont(name: "Inter-Regular", size: 14)
//        textField.backgroundColor = UIColor(red: 237/255, green: 238/255, blue: 242/255, alpha: 1)
//        textField.layer.cornerRadius = 10
//    }
//}
//
//extension LogInViewController {
//    
//    //MARK: - add fields validation
//    private func validateFields() -> Bool {
//        
//        guard let email = textFieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines),
//              let password = textFieldPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
//        else { return false }
//        
//        if email.isEmpty || password.isEmpty {
//            showAlert(with: "Some fields are empty. Please fill in all fields.")
//            return false
//        }
//        
//        if !Validator.isValidEmail(for: email) {
//            showAlert(with: "Invalid email. Please try again.")
//            return false
//        }
//        
//        if !Validator.isPasswordValid(for: password) {
//            showAlert(with: "Invalid password. Please try again.")
//            return false
//        }
//        return true
//    }
//}
//
//extension LogInViewController: LoginOutput {
//    
//    func didLoginEnd() {
//        transitionNext()
//    }
//    
//    func didRecieveValidateErrorLogin(with text: String) {
//        showAlert(with: text)
//    }
//}
//
