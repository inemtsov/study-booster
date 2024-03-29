import UIKit
import FirebaseDatabase

class CreateFlashCardViewController: UIViewController {
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    var gradientLayer:CAGradientLayer?
    var setUid: String? = nil
    var difficulty: String = "easy"
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addNewCardButton: UIButton!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var hintTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
    }
    
    @IBAction func tappedCancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedAddNewCardButton(_ sender: Any) {
        if Utilities.validateText(answerTextField) || Utilities.validateText(questionTextField) {
            showError("Please fill in all fields!")
        } else{
            let answer = answerTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let question = questionTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines )
            var hint = hintTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines )
            hint = hint.isEmpty == true ? "Not Hint" : hint
            let uid = NSUUID().uuidString
            ref = Database.database().reference()
            ref?.child("flashcards").child(setUid!).child(uid).setValue(["answer": answer
                , "question": question, "hint": hint, "difficulty": difficulty, "uid": uid, "bookmarked": false]){
                    (error:Error?, ref:DatabaseReference) in
                    if error != nil {
                        self.showError("Error saving user data!")
                    } else{
                        self.navigationController?.popViewController(animated: true)
                    }
            }
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        easyButton.setImage(UIImage(systemName: "circle"), for: .normal)
        mediumButton.setImage(UIImage(systemName: "circle"), for: .normal)
        hardButton.setImage(UIImage(systemName: "circle"), for: .normal)
        switch sender.tag{
        case 1:
            easyButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            easyButton.tintColor = UIColor.green
            difficulty = "easy"
        case 2:
            mediumButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            mediumButton.tintColor = UIColor.orange
            difficulty = "medium"
        case 3:
            hardButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            hardButton.tintColor = UIColor.red
            difficulty = "hard"
        default: break
        }
    }
    
    func setupElements(){
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = self.view.bounds
        gradientLayer?.colors = [UIColor(hexString: "#B588F7").cgColor,  UIColor(hexString: "#4682B4").cgColor]
        self.view.layer.insertSublayer(gradientLayer!, at: 0)
        easyButton.tintColor = UIColor.green
        mediumButton.tintColor = UIColor.orange
        hardButton.tintColor = UIColor.red
        Utilities.styleCreateButton(addNewCardButton)
        Utilities.styleBackButton(cancelButton)
        errorLabel.alpha = 0
    }
    
    func showError(_ error: String) -> Void {
        errorLabel.text = error
        errorLabel.alpha = 1
    }
}
