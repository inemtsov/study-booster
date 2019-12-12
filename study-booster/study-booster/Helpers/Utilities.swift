import Foundation
import UIKit

class Utilities {
    static func styleTextField(_ textfield:UITextField) {
        // Create the bottom line
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width - 20, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        // Remove border on text field
        textfield.borderStyle = .roundedRect
    }
    static func styleSignUp(_ button:UIButton) {
        styleButton(button, hex: "#FFEDBC")
    }
    
    static func styleSignIn(_ button:UIButton) {
        styleButton(button, hex: "#24C6DC")
    }
    static func styleBackButton(_ button:UIButton) {
        styleButton(button, hex: "#ffd89b")
    }
    
    static func styleLoginSignUpButton(_ button:UIButton) {
        styleButton(button, hex: "#43cea2")
    }
    
    static func styleFlashCardButton(_ button:UIButton) {
        styleButton(button, hex: "#f8f8ff")
    }

    static func styleCreateButton(_ button:UIButton) {
        styleButton(button, hex: "#24C6DC")
    }
    
    static func styleButton(_ button:UIButton, hex: String) {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitleColor(UIColor(hexString: hex), for: .normal)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func validateFields(_ emailTextField: UITextField, _ passwordTextField: UITextField ) -> String? {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields!"
        }
        
        guard var password = passwordTextField.text else {
            return "Something went wrong!!"
        }
        password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(password) != true {
            return "Password Invalid(8 chars)!"
        }
        return nil;
    }
    
    static func validateText(_ textField: UITextField ) -> Bool {
        
        if textField.text?.isEmpty == true || textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return true
        }
        return false;
    }
}
