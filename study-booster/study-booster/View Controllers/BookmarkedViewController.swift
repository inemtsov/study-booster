import UIKit
import FirebaseDatabase

class BookmarkedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    var cards = [Flashcard]()
    var cardSetUid: String? = nil
    var cardSetTitle: String? = nil
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "flashcardHeader") as? Header else {return UIView()}
        header.nameLabel.text = "Flashcards: \(cards.count)"
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FlashcardCell", for: indexPath) as? FlashcardCell else {return UITableViewCell()}
        return FlashcardCell.structure(cards: cards, cell: cell, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let flashCardViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboard.flashcardViewController) as? FlashcardViewController else { return }
        flashCardViewController.setTitle = cardSetTitle
        flashCardViewController.cardSetUid = cardSetUid
        flashCardViewController.cards = cards
        flashCardViewController.startIndex = indexPath.row
        navigationController?.pushViewController(flashCardViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.blue
    }
    
    @IBAction func tappedBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupTableView(){
        ref = getDatabaseReference()
        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "flashcardHeader")
        tableView.register(FlashcardCell.self, forCellReuseIdentifier: "FlashcardCell")
        tableView.sectionHeaderHeight = 50
        tableView.separatorColor = UIColor.orange
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getDatabaseReference() -> DatabaseReference?{
        return Database.database().reference()
    }
}
