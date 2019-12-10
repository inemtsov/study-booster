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
        contentView.addSubview(imageContainer)
        imageContainer.addSubview(flashcardDifficulty)
        contentView.addSubview(answerContainer)
        answerContainer.addSubview(flashcardAnswer)
        contentView.addSubview(imageContainerArrow)
        
        imageContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        imageContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imageContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor,  constant: -10).isActive = true
        
        answerContainer.leadingAnchor.constraint(equalTo: self.imageContainer.leadingAnchor, constant: 50).isActive = true
        answerContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        answerContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        answerContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        
        NSLayoutConstraint.activate([
            imageContainerArrow.heightAnchor.constraint(equalToConstant: 15),
            imageContainerArrow.widthAnchor.constraint(equalToConstant: 15),
            
            imageContainerArrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageContainerArrow.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
    }
    
    let flashcardAnswer:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
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
    
    let imageContainerArrow:UIImageView = {
        guard let image = UIImage(systemName: "chevron.right") else { return UIImageView() }
        let view = UIImageView(image: image)
        view.tintColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
