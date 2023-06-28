//
//  SignupController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 31.03.23.
//

import Foundation
import UIKit
import SnapKit
import Firebase
import GoogleSignIn

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    private let presenter: SignupInputProtocol
    
    //MARK: - header label
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Let's get started!"
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.font = UIFont(name: "Inter-Bold", size: 26)
        labelHeader.numberOfLines = 1
        view.addSubview(labelHeader)
        return labelHeader
    }()
    
    //MARK: - textfield full name
    private lazy var textFieldName: UITextField = {
        let textFieldName = UITextField()
        textFieldName.textContentType = .name
        textFieldName.attributedPlaceholder = NSAttributedString(string: "Full Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 126/255, green: 131/255, blue: 137/255, alpha: 1)])
        textFieldName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldName.frame.height))
        textFieldName.delegate = self
        textFieldName.tag = 0
        
        //add common style parameters
        setupCommonStyleForTextFields(textFieldName)
        view.addSubview(textFieldName)
        return textFieldName
    }()
    
    //MARK: - textfield email address
    private lazy var textFieldEmail: UITextField = {
        let textFieldEmail = UITextField()
        textFieldEmail.textContentType = .emailAddress
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 126/255, green: 131/255, blue: 137/255, alpha: 1)])
        textFieldEmail.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldName.frame.height))
        textFieldEmail.delegate = self
        textFieldEmail.tag = 1
        
        //add common style parameters
        setupCommonStyleForTextFields(textFieldEmail)
        view.addSubview(textFieldEmail)
        return textFieldEmail
    }()
    
    //MARK: - textfield password
    private lazy var textFieldPassword: UITextField = {
        let textFieldPassword = UITextField()
        textFieldPassword.textContentType = .password
        textFieldPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 126/255, green: 131/255, blue: 137/255, alpha: 1)])
        textFieldPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldName.frame.height))
        textFieldPassword.delegate = self
        textFieldPassword.tag = 2
        textFieldPassword.isSecureTextEntry.toggle()
        
        //add common style parameters
        setupCommonStyleForTextFields(textFieldPassword)
        textFieldPassword.enablePasswordToggle()
        view.addSubview(textFieldPassword)
        return textFieldPassword
    }()
    
    //MARK: - textfield confirm password
    private lazy var textFieldConfirmPassword: UITextField = {
        let textFieldConfirmPassword = UITextField()
        textFieldConfirmPassword.textContentType = .password
        textFieldConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 126/255, green: 131/255, blue: 137/255, alpha: 1)])
        textFieldConfirmPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldName.frame.height))
        textFieldConfirmPassword.delegate = self
        textFieldConfirmPassword.tag = 3
        textFieldConfirmPassword.isSecureTextEntry.toggle()
        
        //add common style parameters
        setupCommonStyleForTextFields(textFieldConfirmPassword)
        textFieldConfirmPassword.enablePasswordToggle()
        view.addSubview(textFieldConfirmPassword)
        return textFieldConfirmPassword
    }()
    
    //MARK: - sign up button
    private lazy var buttonSignUp: UIButton = {
        let buttonSignUp = UIButton()
        buttonSignUp.backgroundColor = UIColor(red: 43/255, green: 125/255, blue: 246/255, alpha: 1)
        buttonSignUp.layer.cornerRadius = 10
        buttonSignUp.setTitle("Sign up", for: .normal)
        buttonSignUp.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)
        view.addSubview(buttonSignUp)
        return buttonSignUp
    }()
    
    //MARK: - google auth button
    private lazy var GIDSignInButton: UIButton = {
        let GIDSignInButton = UIButton()
        GIDSignInButton.leftImage(image: UIImage(named: "googleTitle")!, renderMode: .alwaysOriginal)
        GIDSignInButton.backgroundColor = .white
        GIDSignInButton.layer.cornerRadius = 10
        GIDSignInButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        GIDSignInButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        GIDSignInButton.layer.shadowOpacity = 1.0
        GIDSignInButton.layer.shadowRadius = 20
        GIDSignInButton.layer.masksToBounds = false
        view.addSubview(GIDSignInButton)
        return GIDSignInButton
    }()
    
    //MARK: - activity indicator
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        return activityIndicator
    }()
    
    init(presenter: SignupInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        setupLabelHeader()
        setupTextFieldName()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupTextFieldConfirmPassword()
        setupTapToHideKeyboard()
        setupIndicator()
        setupButtonSignUp()
        setupButtonGoogle()
    }
    
    //MARK: - label header
    private func setupLabelHeader() {
        
        //constraints
        labelHeader.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(120)
            make.leading.equalTo(textFieldName.snp.leading)
            make.width.equalTo(220)
            make.height.equalTo(35)
        })
    }
    
    //MARK: - text field name
    private func setupTextFieldName() {
        
        //constraints
        textFieldName.snp.makeConstraints({ make in
            make.top.equalTo(labelHeader.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(345)
            make.height.equalTo(48)
        })
    }
    
    //MARK: - text field email
    private func setupTextFieldEmail() {
        
        //constraints
        textFieldEmail.snp.makeConstraints({ make in
            make.top.equalTo(textFieldName.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(345)
            make.height.equalTo(48)
        })
    }
    
    //MARK: - text field password
    private func setupTextFieldPassword() {
        
        //constraints
        textFieldPassword.snp.makeConstraints({ make in
            make.top.equalTo(textFieldEmail.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(345)
            make.height.equalTo(48)
        })
    }
    
    //MARK: - text field confirm password
    private func setupTextFieldConfirmPassword() {
        
        //constraints
        textFieldConfirmPassword.snp.makeConstraints({ make in
            make.top.equalTo(textFieldPassword.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(345)
            make.height.equalTo(48)
        })
    }
    
    //MARK: - indicator activity view
    private func setupIndicator() {
        
        //constraints
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().inset(-40)
        }
    }
    
    //MARK: - button sign up
    private func setupButtonSignUp() {
        
        //constraints
        buttonSignUp.snp.makeConstraints( { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textFieldConfirmPassword.snp.bottom).offset(40)
            make.width.equalTo(335)
            make.height.equalTo(48)
        })
        
        //MARK: - create action on the next view
        buttonSignUp.addTarget(self, action: #selector(actionForSignupButton), for: .touchUpInside)
    }
    
    //MARK: - button google
    private func setupButtonGoogle() {
        
        //constraints
        GIDSignInButton.snp.makeConstraints( { make in
            make.leading.equalTo(buttonSignUp.snp.leading)
            make.top.equalTo(buttonSignUp.snp.bottom).offset(16)
            make.width.equalTo(335)
            make.height.equalTo(48)
        })
        
        //MARK: - create action on the next view
        GIDSignInButton.addTarget(self, action: #selector(actionForGoogleButton), for: .touchUpInside)
    }
    
    //MARK: - action to the next screen
    @objc func actionForSignupButton() {
        
        let isValid = loginValidateFields()
        
        if isValid {
            guard let email = textFieldEmail.text,
                  let name = textFieldName.text,
                  let password = textFieldPassword.text else { return }
            
            let user = Register(name: name, email: email, password: password)
            self.presenter.signUpWithUsername(user: user)
        }
    }
    
    //MARK: - action to the next view with google button
    @objc func actionForGoogleButton() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard let result else { return }
            self.presenter.signUpWithGoogle(with: result)
        }
    }
    
    private func transitionNext() {
        let viewModel = ChoosePassportViewModel()
        let chooseVC = ChoosePassportViewController(viewModel: viewModel)
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.navigationController?.pushViewController(chooseVC, animated: true)
        }
    }
    
    //MARK: - tap to hide keyboard from any point on view
    private func setupTapToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func showAlert(with text: String) {
        let alertError = UIAlertController(title: "Sign Up Failed", message: text, preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertError, animated: true)
    }
}

//MARK: - set eye button to hide and show password
extension UITextField {
    func setPasswordToggleImage(_ button: UIButton) {
        button.tintColor = UIColor(red: 126/255, green: 131/255, blue: 137/255, alpha: 1)
        if isSecureTextEntry {
            button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
    func enablePasswordToggle() {
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}

//MARK: - text field improvements
extension SignupViewController {
    
    //MARK: - add switch between text fields with button return
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            //if not found then remove keyboard
            textField.resignFirstResponder()
        }
        return false
    }
    
    //MARK: - add common style functions for text fields
    private func setupCommonStyleForTextFields(_ textField: UITextField) {
        textField.leftViewMode = .always
        textField.textColor = UIColor(red: 126/255, green: 131/255, blue: 137/255, alpha: 1)
        textField.font = UIFont(name: "Inter-Regular", size: 14)
        textField.backgroundColor = UIColor(red: 237/255, green: 238/255, blue: 242/255, alpha: 1)
        textField.layer.cornerRadius = 10
    }
}

//MARK: - add image on the google button
extension UIButton {
    func leftImage(image: UIImage, renderMode: UIImage.RenderingMode) {
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 15, left: image.size.width, bottom: 15, right: image.size.width)
        self.contentHorizontalAlignment = .center
        self.imageView?.contentMode = .scaleAspectFit
    }
}

extension SignupViewController {
    
    //MARK: - add fields validation
    private func loginValidateFields() -> Bool {
        
        guard let name = textFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let email = textFieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = textFieldPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let confirmPassword = textFieldConfirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        else { return false }
        
        if name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            showAlert(with: "Some fields are empty. Please fill in all fields.")
            return false
        }
        
        if !Validator.isValidUsername(for: name) {
            showAlert(with: "Invalid name format.")
            return false
        }
        
        if !Validator.isValidEmail(for: email) {
            showAlert(with: "Invalid email format. Please try again.")
            return false
        }
        
        if !Validator.isPasswordValid(for: password) {
            showAlert(with: "Invalid password format. It should contain at least one digit and be between 6 and 32 characters long.")
            return false
        }
        
        if password != confirmPassword {
            showAlert(with: "Passwords don't match. Please try again.")
            return false
        }

        return true
    }
}

extension SignupViewController: SignUpOutput {
    func didRecieveValidateError(with text: String) {
        showAlert(with: text)
    }
    
    func didRegisterEnd() {
        transitionNext()
    }
}


