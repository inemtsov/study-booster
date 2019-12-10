import UIKit
import FirebaseDatabase

class SetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var userUid: String? = nil
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var subjects = [Subject]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "headerId")
        tableView.register(SubjectCell.self, forCellReuseIdentifier: "Cell")
        tableView.sectionHeaderHeight = 50
        tableView.separatorColor = UIColor.orange
        
        tableView.delegate = self
        tableView.dataSource = self
        ref = Database.database().reference()
        databaseHandle = ref?.child("users").child("1234").child("subjects").observe(.childAdded, with: { (snapshot) in
            let subject = snapshot.value as? [String:Any]
            
            if let actualSubject = subject {
                if let title = actualSubject["title"] as? String, let description = actualSubject["description"] as? String, let uid = actualSubject["uid"] as? String {
                    self.subjects.append(Subject(title: title, description: description, uid: uid))
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId") as? Header else {return Header()}
        header.nameLabel.text = "Sets: \(subjects.count)"
        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.blue
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SubjectCell else {return UITableViewCell()}
        return structure(cell: cell, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.transitionToSet(uid: subjects[indexPath.row].uid, title: subjects[indexPath.row].title )
    }
    
    @IBAction func createSetTapped(_ sender: Any) {
        self.transitionToCreateSet(uid: "fakeuid")
    }
    
    func transitionToCreateSet(uid: String) -> Void {
        guard let createSetViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboard.createSetViewController) as? CreateSetViewController else { return }
        createSetViewController.userUid = uid
        navigationController?.pushViewController(createSetViewController, animated: true)
    }
    
    func transitionToSet(uid: String, title: String ) {
        guard let setViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboard.flashCardsSetViewController) as? FlashCardsSetViewController else { return }
        setViewController.cardSetUid = uid
        setViewController.cardSetTitle = title
        navigationController?.pushViewController(setViewController, animated: true)
    }
    
    @IBAction func tappedLogOutButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func structure(cell: SubjectCell, indexPath: IndexPath) -> SubjectCell{
        cell.titleContainer.backgroundColor = nil
        cell.descriptionContainer.backgroundColor = nil
        cell.subjectTitle.text = nil
        cell.subjectDescription.text = nil
        print(subjects)
        
        cell.subjectTitle.text = subjects[indexPath.row].title
        cell.subjectDescription.text = subjects[indexPath.row].description.count > 30 ? "\(subjects[indexPath.row].description.prefix(30))..." : subjects[indexPath.row].description
        
        if(indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor(hexString: "#DCDCDC")
            cell.imageContainer.tintColor = UIColor.white
            
        }
        return cell
    }
}
