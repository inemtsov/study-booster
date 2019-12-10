import UIKit
import FirebaseDatabase

class FlashCardsSetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var cardSetUid: String? = nil
    var cardSetTitle: String? = nil
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    @IBOutlet weak var addNewFlashCardButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var flashcards = [Flashcard]()
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var bookmarkedSetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = getDatabaseReference()
        retrieveSet(ref: ref)
        guard let title = cardSetTitle else {
            return
        }
        setLabel.text = title
        
        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "headerId1")
        tableView.register(FlashcardCell.self, forCellReuseIdentifier: "FlashcardCell")
        tableView.sectionHeaderHeight = 50
        tableView.separatorColor = UIColor.orange
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func retrieveSet(ref: DatabaseReference?){
        databaseHandle = ref?.child("flashcards").child(self.cardSetUid!).observe(.childAdded, with: { (snapshot) in
            let flashcard = snapshot.value as? [String:Any]
            if let actualFlashcard = flashcard {
                if let question = actualFlashcard["question"] as? String,
                    let answer = actualFlashcard["answer"] as? String,
                    let hint = actualFlashcard["hint"] as? String,
                    let difficulty = actualFlashcard["difficulty"] as? String,
                    let uid = actualFlashcard["uid"] as? String,
                    let bookmarked = actualFlashcard["bookmarked"] as? Bool {
                    self.flashcards.append(Flashcard(question: question, answer: answer, difficulty: difficulty, hint: hint, uid: uid, bookmarked: bookmarked ))
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId1") as? Header else {return UIView()}
        header.nameLabel.text = "Flashcards: \(flashcards.count)"
        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.blue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FlashcardCell", for: indexPath) as? FlashcardCell else {return UITableViewCell()}
        return structure(cell: cell, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let flashCardViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboard.flashcardViewController) as? FlashcardViewController else { return }
        flashCardViewController.setTitle = cardSetTitle
        flashCardViewController.cardSetUid = cardSetUid
        flashCardViewController.cards = flashcards
        flashCardViewController.startIndex = indexPath.row
        navigationController?.pushViewController(flashCardViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flashcards.count
    }
    
    @IBAction func tappedDoneButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedCreateFlashcardButton(_ sender: Any) {
        self.transitionToCreateFlashcard(uid: cardSetUid)
    }
    
    func transitionToCreateFlashcard(uid: String?){
        guard let createFlashCardViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboard.createFlashcardController) as? CreateFlashCardViewController else { return }
        createFlashCardViewController.setUid = cardSetUid!
        navigationController?.pushViewController(createFlashCardViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            ref = getDatabaseReference()
            ref?.child("flashcards").child(self.cardSetUid!).child(flashcards[indexPath.row].uid).removeValue(){
                (error:Error?, ref:DatabaseReference) in
                if let error = error {
                    print("data can't be deleted: \(error)")
                } else {
                    self.flashcards.remove(at: indexPath.row)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func tappedBookmarkedButton(_ sender: Any) {
        guard let bookmarkedViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboard.bookmarkedViewController) as? BookmarkedViewController else { return }
        bookmarkedViewController.cards = flashcards.filter{ ($0.bookmarked == true) }
        bookmarkedViewController.cardSetUid = cardSetUid
        bookmarkedViewController.cardSetTitle = cardSetTitle
        navigationController?.pushViewController(bookmarkedViewController, animated: true)
    }
    
    private func getDatabaseReference() -> DatabaseReference?{
        return Database.database().reference()
    }
    
    private func structure(cell: FlashcardCell, indexPath: IndexPath) -> FlashcardCell{
        cell.imageContainer.backgroundColor = nil
        cell.answerContainer.backgroundColor = nil
        cell.flashcardAnswer.text = nil
        cell.flashcardAnswer.text = flashcards[indexPath.row].answer.count > 50 ? "\(flashcards[indexPath.row].answer.prefix(50))..." : flashcards[indexPath.row].question
        var image: UIImage?
        var color: UIColor?
        switch flashcards[indexPath.row].difficulty {
        case "easy":
            image = UIImage(systemName: "e.circle.fill")
            color = UIColor.green
        case "medium":
            image = UIImage(systemName: "m.circle.fill")
            color = UIColor.orange
        case "hard":
            image = UIImage(systemName: "h.circle.fill")
            color = UIColor.red
        default: image = UIImage(systemName: "circle.fill")
        color = UIColor.black
        }
        cell.flashcardDifficulty.image = image
        cell.flashcardDifficulty.tintColor = color
        return cell
    }
}
