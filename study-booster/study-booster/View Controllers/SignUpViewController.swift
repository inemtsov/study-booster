import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    var gradientLayer:CAGradientLayer?
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleLoginSignUpButton(signUpButton)
        Utilities.styleBackButton(backButton)
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = self.view.bounds
        gradientLayer?.colors = [UIColor(hexString: "#5f2c82").cgColor, UIColor(hexString: "#49a09d").cgColor]
        self.view.layer.insertSublayer(gradientLayer!, at: 0)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        let error = Utilities.validateFields(emailTextField, passwordTextField)
        if error != nil {
            showError(error!)
        } else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError("error creating user!")
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["email": email, "uid": result!.user.uid]) { (error) in
                        if error != nil {
                            self.showError("Error saving user data!")
                        }
                    }
                    self.transitionToHome(result!.user.uid)
                }
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func showError(_ error: String) -> Void {
        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
    func transitionToHome(_ uid: String) -> Void {
        let setViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboard.setViewController) as? SetViewController
        setViewController?.userUid = uid
        navigationController?.pushViewController(setViewController!, animated: true)
    }
}
