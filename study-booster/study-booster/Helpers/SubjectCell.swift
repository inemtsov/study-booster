import UIKit

class SubjectCell: UITableViewCell {
    
    var subject: Subject?{
        didSet{
            guard let unwrappedSubject = subject else { return }
            subjectTitle.text = unwrappedSubject.title
            subjectDescription.text = unwrappedSubject.description
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleContainer)
        titleContainer.addSubview(subjectTitle)
        contentView.addSubview(descriptionContainer)
        descriptionContainer.addSubview(subjectDescription)
        
        titleContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        titleContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        titleContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor,  constant: -10).isActive = true
        
        descriptionContainer.leadingAnchor.constraint(equalTo: self.titleContainer.leadingAnchor, constant: 50).isActive = true
        descriptionContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        descriptionContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        descriptionContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    let subjectTitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    let subjectDescription:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let titleContainer:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let descriptionContainer:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
