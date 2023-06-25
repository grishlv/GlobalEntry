//
//  LogInViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 12.04.23.

import Foundation
import UIKit
import SnapKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - header label
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Login"
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.font = UIFont(name: "Inter-Bold", size: 26)
        labelHeader.numberOfLines = 1
        view.addSubview(labelHeader)
        return labelHeader
    }()
    
    //MARK: - textfield email address
    private lazy var textFieldEmail: UITextField = {
        let textFieldEmail = UITextField()
        //add common style parameters
        setupCommonStyleForTextFields(textFieldEmail)
        
        textFieldEmail.textContentType = .emailAddress
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 126/255, green: 131/255, blue: 137/255, alpha: 1)])
        textFieldEmail.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldEmail.frame.height))
        textFieldEmail.delegate = self
        textFieldEmail.tag = 1
        
        view.addSubview(textFieldEmail)
        return textFieldEmail
    }()
    
    //MARK: - textfield password
    private lazy var textFieldPassword: UITextField = {
        let textFieldPassword = UITextField()
        //add common style parameters
        setupCommonStyleForTextFields(textFieldPassword)
        textFieldPassword.enablePasswordToggle()
        
        textFieldPassword.textContentType = .password
        textFieldPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 126/255, green: 131/255, blue: 137/255, alpha: 1)])
        textFieldPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldPassword.frame.height))
        textFieldPassword.delegate = self
        textFieldPassword.tag = 2
        textFieldPassword.isSecureTextEntry.toggle()
        
        view.addSubview(textFieldPassword)
        return textFieldPassword
    }()
    
    //MARK: - log in button
    private lazy var buttonLogIn: UIButton = {
        let buttonLogIn = UIButton()
        buttonLogIn.backgroundColor = UIColor(red: 43/255, green: 125/255, blue: 246/255, alpha: 1)
        buttonLogIn.layer.cornerRadius = 10
        buttonLogIn.setTitle("Login", for: .normal)
        buttonLogIn.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)
        view.addSubview(buttonLogIn)
        return buttonLogIn
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        setupLabelHeader()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupTapToHideKeyboard()
        setupButtonLogIn()
        setupButtonGoogle()
    }
    
    //MARK: - label header
    private func setupLabelHeader() {
        
        //constraints
        labelHeader.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(120)
            make.leading.equalTo(textFieldEmail.snp.leading)
            make.width.equalTo(220)
            make.height.equalTo(35)
        })
    }
    
    //MARK: - text field name
    private func setupTextFieldEmail() {
        
        //constraints
        textFieldEmail.snp.makeConstraints({ make in
            make.top.equalTo(labelHeader.snp.bottom).offset(16)
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
    
    //MARK: - button log in
    func setupButtonLogIn() {
        
        //constraints
        buttonLogIn.snp.makeConstraints( { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textFieldPassword.snp.bottom).offset(40)
            make.width.equalTo(335)
            make.height.equalTo(48)
        })
        
        //MARK: - create action on the next view
        buttonLogIn.addTarget(self, action: #selector(actionForLogInButton), for: .touchUpInside)
    }
    
    //MARK: - button google
    private func setupButtonGoogle() {
        
        //constraints
        GIDSignInButton.snp.makeConstraints( { make in
            make.leading.equalTo(buttonLogIn.snp.leading)
            make.top.equalTo(buttonLogIn.snp.bottom).offset(16)
            make.width.equalTo(335)
            make.height.equalTo(48)
        })
        
        //MARK: - create action on the next view
        GIDSignInButton.addTarget(self, action: #selector(actionForGoogleButton), for: .touchUpInside)
    }
    
    func validateFields() -> String? {
        
        //Check that all fields are filled in
        if textFieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            textFieldPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        return nil
    }
    
    //MARK: - action to the next view
    @objc func actionForLogInButton() {
        
        let error = validateFields()
        
        if error != nil {
            let alertEmptyFields = UIAlertController(title: "Some fields are empty", message: "Please fill in all fields", preferredStyle: .alert)
            alertEmptyFields.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertEmptyFields, animated: true, completion: {
                return
            })
        } else {
            
            //MARK: - give info in firebase
            guard let email = textFieldEmail.text, !email.isEmpty else { return }
            guard let password = textFieldPassword.text, !password.isEmpty else { return }
            
            let db = Firestore.firestore()
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, err) in
                
                if err != nil {
                    let alertError = UIAlertController(title: "Something is wrong", message: "Please check your email & password and try again", preferredStyle: .alert)
                    alertError.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alertError, animated: true, completion: {
                        return
                    })
                    
                } else {
                    let chooseVC = ChoosePassportViewController()
                    self?.navigationController?.pushViewController(chooseVC, animated: true)
                }
            }
        }
    }
    
    //MARK: - action to the next view with google button
    @objc func actionForGoogleButton() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else { return }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("Error signing in with Firebase: \(error.localizedDescription)")
                    return
                }
            }
            self.transitionNext()
        }
    }
    
    func transitionNext() {
        let chooseVC = ChoosePassportViewController()
        navigationController?.pushViewController(chooseVC, animated: true)
    }
    
    //MARK: - tap to hide keyboard from any point on view
    private func setupTapToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
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

//MARK: - add switch between text fields with button return
extension LogInViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            //if not found then remove keyboard
            textField.resignFirstResponder()
        }
        return false
    }
}

//MARK: - validate text field that it's not empty
extension UITextField {
    private func isValid(_ word: String) -> Bool {
        guard let text = self.text, !text.isEmpty
        else {
            print("Please fill the field.")
            return false }
        
        guard text.contains(word) else {
            print("Wrong word. Please check again.")
            return false
        }
        return true
    }
}
