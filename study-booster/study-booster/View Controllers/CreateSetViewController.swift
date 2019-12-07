import UIKit
import FirebaseDatabase

class CreateSetViewController: UIViewController {
    var userUid: String? = nil
    @IBOutlet weak var descriptionTextView: UITextField!
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var createSetButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background2.jpg")!)

        setUpElements()
    }
               
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
                   
        Utilities.styleTextField(titleTextView)
        Utilities.styleTextField(descriptionTextView)
        Utilities.styleHollowButton(createSetButton)
        Utilities.styleFilledButton(backButton)
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
                    self.transitionToFlashCardsSet(uid: uid, title: title)
                }
            }
        }
    }
    
    func transitionToFlashCardsSet(uid: String, title: String) -> Void {
       guard let flashCardsSetViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboard.flashCardsSetViewController) as? FlashCardsSetViewController else { return }
        flashCardsSetViewController.cardSetUid = uid
        flashCardsSetViewController.cardSetTitle = title
        navigationController?.pushViewController(flashCardsSetViewController, animated: true)
    }
    
    func showError(_ error: String) -> Void {
        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
}



