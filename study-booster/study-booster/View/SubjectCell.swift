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
        contentView.addSubview(imageContainer)
        
        titleContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        titleContainer.trailingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor).isActive = true
        titleContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleContainer.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        descriptionContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 150).isActive = true
        descriptionContainer.trailingAnchor.constraint(equalTo: imageContainer.leadingAnchor).isActive = true
        descriptionContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        descriptionContainer.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        
        
        NSLayoutConstraint.activate([
            subjectTitle.topAnchor.constraint(equalTo: titleContainer.topAnchor),
            subjectTitle.leftAnchor.constraint(equalTo: titleContainer.leftAnchor),
            subjectTitle.rightAnchor.constraint(equalTo: titleContainer.rightAnchor),
            subjectTitle.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor),
            
            subjectDescription.topAnchor.constraint(equalTo: descriptionContainer.topAnchor),
            subjectDescription.leftAnchor.constraint(equalTo: descriptionContainer.leftAnchor),
            subjectDescription.rightAnchor.constraint(equalTo: descriptionContainer.rightAnchor),
            subjectDescription.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor),
            
            imageContainer.heightAnchor.constraint(equalToConstant: 15),
            imageContainer.widthAnchor.constraint(equalToConstant: 15),
            imageContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
        
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
    
    let imageContainer:UIImageView = {
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
