//
//  TextFieldExtenstions.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 06.04.23.
//

import Foundation
import UIKit

//MARK: - add switch between text fields with button return
extension UITextField {
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
}

//MARK: - validate text field that it's not empty
extension UITextField {
    func isValid(_ word: String) -> Bool {
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
