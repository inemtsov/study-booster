import UIKit
import FirebaseDatabase

class CreateSetViewController: UIViewController {
    
    var userUid: String? = nil
    var gradientLayer:CAGradientLayer?
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    @IBOutlet weak var descriptionTextView: UITextField!
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var createSetButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        
        Utilities.styleTextField(titleTextView)
        Utilities.styleTextField(descriptionTextView)
        Utilities.styleCreateButton(createSetButton)
        Utilities.styleBackButton(backButton)
        
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = self.view.bounds
        gradientLayer?.colors = [UIColor(hexString: "#1153FC").cgColor, UIColor(hexString: "#B0E0E6").cgColor]
        self.view.layer.insertSublayer(gradientLayer!, at: 0)
    }
    
    @IBAction func backButton(_ sender: Any) {
        toPreviuousView()
    }
    
    @IBAction func createTapped(_ sender: Any) {
        if Utilities.validateText(titleTextView) || Utilities.validateText(descriptionTextView) {
            showError("Please fill in all fields!")
        } else{
            let title = titleTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let description = descriptionTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines )
            let uid = NSUUID().uuidString
            ref = Database.database().reference()
            ref?.child("users").child(userUid!).child("subjects").child(uid).setValue(["title": title
                , "description": description, "uid": uid]){
                    (error:Error?, ref:DatabaseReference) in
                    if error != nil {
                        self.showError("Error saving user data!")
                    } else{
                        self.toPreviuousView()
                    }
            }
        }
    }
    
    func toPreviuousView(){
        navigationController?.popViewController(animated: true)
    }
    
    func showError(_ error: String) -> Void {
        errorLabel.text = error
        errorLabel.alpha = 1
    }
}
