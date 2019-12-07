import UIKit

class FlashcardCell: UITableViewCell {
    
    var flashcard: Flashcard?{
        didSet{
            guard let unwrappedFlashcard = flashcard else { return }
            flashcardAnswer.text = unwrappedFlashcard.answer

        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
          contentView.addSubview(imageContainer)
          imageContainer.addSubview(flashcardDifficulty)
          contentView.addSubview(answerContainer)
          answerContainer.addSubview(flashcardAnswer)

        imageContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        imageContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imageContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor,  constant: -10).isActive = true

        answerContainer.leadingAnchor.constraint(equalTo: self.imageContainer.leadingAnchor, constant: 50).isActive = true
        answerContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        answerContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        answerContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    let flashcardAnswer:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
//    
//    switch text {
//    case "easy":
//        UIImage(systemName: "e.circle.fill")
//    case "medium":
//        UIImage(systemName: "m.circle.fill")
//    case "hard":
//        UIImage(systemName: "h.circle.fill")
//    default:
//        UIImage(systemName: "circle.fill")
//    }
    
    let flashcardDifficulty:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let imageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let answerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    func setupViews(){
//        addSubview(flashcardDifficulty)
//        addSubview(flashcardAnswer)
//        addSubview(deleteButton)
////
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0(20)]-16-[v1]-8-[v2]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": flashcardDifficulty, "v1": flashcardAnswer, "v2": deleteButton]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": flashcardDifficulty]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": flashcardAnswer]))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
