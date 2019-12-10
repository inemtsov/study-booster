import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    var gradientLayer:CAGradientLayer?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = self.view.bounds
        let color1 = UIColor(hexString: "#2193bo")
        let color2 = UIColor(hexString: "#6dd5ed")
        gradientLayer?.colors = [color2.cgColor, color1.cgColor]
        self.view.layer.insertSublayer(gradientLayer!, at: 0)
        
        setUpElements()
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleLoginSignUpButton(loginButton)
        Utilities.styleBackButton(backButton)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
