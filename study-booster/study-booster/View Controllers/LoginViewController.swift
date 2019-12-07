import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background6-1.jpg")!)
        setUpElements()
    }
        
        func setUpElements(){
            errorLabel.alpha = 0
            
            Utilities.styleTextField(emailTextField)
            Utilities.styleTextField(passwordTextField)
            Utilities.styleFilledButton(loginButton)
            Utilities.styleFilledButton(backButton)

        }

    @IBAction func logginTapped(_ sender: Any) {
        let error = Utilities.validateFields(emailTextField, passwordTextField)
               if error != nil {
                self.showError(error!)
               } else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

                Auth.auth().signIn(withEmail: email, password: password){
                    (result, err) in
                    if err != nil {
                        self.showError(err!.localizedDescription)
                    } else {
                        self.transitionToHome(result!.user.uid)
                    }
                }
        }
    }
    
    func showError(_ error: String) -> Void {
        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
    func transitionToHome(_ uid: String) -> Void {
        let setViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboard.setViewController) as? SetViewController
        
        setViewController?.userUid = uid
        view.window?.rootViewController = setViewController
        view.window?.makeKeyAndVisible()
    }
}
