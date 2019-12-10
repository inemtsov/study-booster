import UIKit
import FirebaseDatabase

class CreateSetViewController: UIViewController {
    var userUid: String? = nil
    var gradientLayer:CAGradientLayer?
    
    @IBOutlet weak var descriptionTextView: UITextField!
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var createSetButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = self.view.bounds
        let color1 = UIColor(hexString: "#B0E0E6")
        let color2 = UIColor(hexString: "#1153FC")
        gradientLayer?.colors = [color2.cgColor, color1.cgColor]
        self.view.layer.insertSublayer(gradientLayer!, at: 0)
        
        setUpElements()
    }
    
    @IBAction func backButton(_ sender: Any) {
        toPreviuousView()
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
        
        Utilities.styleTextField(titleTextView)
        Utilities.styleTextField(descriptionTextView)
        Utilities.styleCreateButton(createSetButton)
        Utilities.styleBackButton(backButton)
    }
    
    @IBAction func createTapped(_ sender: Any) {
        if Utilities.validateText(titleTextView) || Utilities.validateText(descriptionTextView) {
            showError("Please fill in all fields!")
        } else{
            let title = titleTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let description = descriptionTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines )
            let uid = NSUUID().uuidString
            ref = Database.database().reference()
            ref?.child("users").child("1234").child("subjects").child(uid).setValue(["title": title
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



