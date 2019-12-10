import UIKit
import AVFoundation
import FirebaseDatabase

class FlashcardViewController: UIViewController {
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    var cards: [Flashcard]?
    var cardSetUid: String?
    var setTitle: String?
    var startIndex: Int = 0
    var iKnow = 0
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    var count: Int = 0
    var iKnowIndexes = [Int]()
    var gradientLayer:CAGradientLayer?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    @IBOutlet weak var bookMarkButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var hintButton: UIButton!
    
    @IBOutlet weak var getAnswerButton: UIButton!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var difficultyLevelLabel: UILabel!
    @IBOutlet weak var iKnowButton: UIButton!
    @IBOutlet weak var noIdeaButton: UIButton!
    @IBOutlet weak var hintLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = self.view.bounds
        let color1 = UIColor(hexString: "#B7F8DB")
        let color2 = UIColor(hexString: "#50A7C2")
        gradientLayer?.colors = [color2.cgColor, color1.cgColor]
        self.view.layer.insertSublayer(gradientLayer!, at: 0)
        
        Utilities.styleFlashCardButton(noIdeaButton)
        Utilities.styleFlashCardButton(hintButton)
        Utilities.styleFlashCardButton(iKnowButton)

        titleLabel.text = setTitle!
        timeLabel.text = timeString(time: TimeInterval(seconds))

        if cards != nil {
            count =  cards!.count
        }
        setView()
        runTimer()
    }
    
    @IBAction func tappedGetAnswerButton(_ sender: Any) {
        self.cardLabel.fadeOut(completion: {
            (finished: Bool) -> Void in
            self.cardLabel.text = "Bird Type: Swift"
            self.cardLabel.fadeIn()
        })
    }
    
    @IBAction func tappedHintButton(_ sender: Any) {
        hintLabel.alpha = 1
    }
    
    @IBAction func tappedBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func tappedNoIdeaButton(_ sender: Any) {
        startIndex = getNextIndex()
        setView()
        restartTimer()
    }
    
    @IBAction func tappedIKnowButton(_ sender: Any) {
        iKnowIndexes.append(startIndex)
        iKnow+=1
        cardNumberLabel.text = String(iKnow)
        startIndex = getNextIndex()
        setView()
        restartTimer()
    }
    
    private func getNextIndex() -> Int{
        var index = startIndex
        index = (index + 1)%count
        if(iKnow == count){
            navigationController?.popViewController(animated: true)
        }else {
            while(index != startIndex && iKnowIndexes.contains(index)){
                index = (index + 1)%count
            }
        }
        return index
    }
    
    @IBAction func tappedPlayButton(_ sender: Any) {
        guard let textToSpeach = cardLabel.text else {
            return
        }
        let utterance = AVSpeechUtterance(string: textToSpeach)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
    
    @IBAction func tappedBookmarkButton(_ sender: Any) {
        ref = Database.database().reference()
        guard let card = cards?[startIndex] else {
            return
        }
        
        print(cards![startIndex])
        if (!card.bookmarked) {
            ref?.child("flashcards").child(cardSetUid!).child(card.uid).updateChildValues(["bookmarked" : true])
            cards![startIndex].bookmarked = true
            bookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else{
            ref?.child("flashcards").child(cardSetUid!).child(card.uid).updateChildValues(["bookmarked" : false])
            cards![startIndex].bookmarked = false
            bookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
        
    private func setView(){
        hintLabel.alpha = 0
        cardNumberLabel.text = String("\(iKnow)/\(count)")
        
        guard let card = cards?[startIndex] else {
            return
        }
        
        if(cards?[startIndex].bookmarked == true){
            bookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else{
            bookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        hintLabel.text = card.hint
        cardLabel.text = card.question
        difficultyLevelLabel.text = card.difficulty
        difficultyLevelLabel.textColor = UIColor.white
        difficultyLevelLabel.layer.borderWidth = 1.0
        difficultyLevelLabel.layer.cornerRadius = 8.0
        difficultyLevelLabel.layer.masksToBounds = true
        difficultyLevelLabel.backgroundColor = getColor(difficulty: card.difficulty)
    }
    
    private func getColor(difficulty:String) -> UIColor {
        let color: UIColor
        switch difficulty {
        case "easy":
            color = UIColor.systemGreen
        case "medium":
            color = UIColor.orange
        case "hard":
            color = UIColor.red
        default:
            color = UIColor.yellow
        }
        return color
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc private func updateTimer(){
        if seconds < 1 {
            restartTimer()
            startIndex = getNextIndex()
            setView()
        } else {
            seconds -= 1
            timeLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    private func restartTimer(){
        timer.invalidate()
        seconds = 60
        runTimer()
        timeLabel.text = timeString(time: TimeInterval(seconds))
    }
}
