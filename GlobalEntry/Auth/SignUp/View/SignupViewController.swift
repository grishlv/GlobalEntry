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
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

class SignupViewController: UIViewController, UITextFieldDelegate {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        setupLabelHeader()
        setupTextFieldName()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupTextFieldConfirmPassword()
        setupTapToHideKeyboard()
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
    
    func validateFields() -> String? {
        
        //Check that all fields are filled in
        if textFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            textFieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            textFieldPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        return nil
    }
    
    func validatePasswords() -> String? {
        
        //Check that passwords are the same
        if textFieldPassword.text != textFieldConfirmPassword.text {
            return "Passwords aren't correct"
        }
        return nil
    }
    
    //MARK: - action to the next screen
    @objc func actionForSignupButton() {
        
        let errorEmptyFields = validateFields()
        let wrongPasswords = validatePasswords()
        
        if errorEmptyFields != nil {
            let alertEmptyFields = UIAlertController(title: "Some fields are empty", message: "Please fill in all fields", preferredStyle: .alert)
            alertEmptyFields.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertEmptyFields, animated: true, completion: {
                return
            })
        }
        
        if wrongPasswords != nil {
            let alertWrongPasswords = UIAlertController(title: "Passwords are different", message: "Please enter the password again", preferredStyle: .alert)
            alertWrongPasswords.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertWrongPasswords, animated: true, completion: {
                return
            })
        }
        
        else {
            //MARK: - give info in firebase
            guard let email = textFieldEmail.text, !email.isEmpty else { return }
            guard let name = textFieldName.text, !name.isEmpty else { return }
            guard let password = textFieldPassword.text, !password.isEmpty else { return }
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                if err != nil {
                    let alertError = UIAlertController(title: "Error create user", message: "Please try again!", preferredStyle: .alert)
                    alertError.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertError, animated: true, completion: {
                        return
                    })
                    
                } else {
                    let db = Firestore.firestore()
                    guard let resultUser = result?.user else {
                        print("error with result")
                        return }
                    
                    db.collection("users")
                        .document(resultUser.uid)
                        .setData([
                            "email": email,
                            "name": name]) { error in
                                
                                if error != nil {
                                    let alertData = UIAlertController(title: "Error safe data", message: "Please try again!", preferredStyle: .alert)
                                    alertData.addAction(UIAlertAction(title: "OK", style: .default))
                                    self.present(alertData, animated: true, completion: {
                                        return
                                    })
                                }
                            }
                    self.transitionNext()
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
            
            let email = user.profile?.email
            let name = user.profile?.name
            
            Auth.auth().signIn(with: credential) { result, error in
                
                if error != nil {
                    let alertError = UIAlertController(title: "Error create user", message: "Please try again!", preferredStyle: .alert)
                    alertError.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertError, animated: true, completion: {
                        return
                    })
                    
                } else {
                    let db = Firestore.firestore()
                    db.collection("users")
                        .document(credential.provider)
                        .setData([
                            "email": email,
                            "name": name]) { error in
                                
                                if error != nil {
                                    let alertData = UIAlertController(title: "Error safe data", message: "Please try again!", preferredStyle: .alert)
                                    alertData.addAction(UIAlertAction(title: "OK", style: .default))
                                    self.present(alertData, animated: true, completion: {
                                        return
                                    })
                                }
                            }
                    self.transitionNext()
                }
            }
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

//MARK: - set eye button to hide and show password
extension UITextField {
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
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
    
    //MARK: - add switch between text fields with button return
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

//MARK: - add image on the google button
extension UIButton {
    func leftImage(image: UIImage, renderMode: UIImage.RenderingMode) {
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 15, left: image.size.width, bottom: 15, right: image.size.width)
        self.contentHorizontalAlignment = .center
        self.imageView?.contentMode = .scaleAspectFit
    }
}

extension SignupViewController: AlertActions {
    func alertErrorCreate() {
        let alertError = UIAlertController(title: "Error create user", message: "Please try again!", preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertError, animated: true, completion: {
            return
        })
    }
    
    func alertErrorSafeData() {
        let alertData = UIAlertController(title: "Error safe data", message: "Please try again!", preferredStyle: .alert)
        alertData.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertData, animated: true, completion: {
            return
        })
        
    }
}

extension SignupViewController: SignUpOutput {
    func didRegisterEnd() {
        let chooseVC = ChoosePassportViewController()
        navigationController?.pushViewController(chooseVC, animated: true)
    }
}
