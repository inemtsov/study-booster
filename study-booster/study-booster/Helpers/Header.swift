import Foundation
import UIKit

class Header: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier:String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
//
//    let newSetButton: UIButton = {
//        let DoneBut = UIButton(type: UIButton.ButtonType.custom)
//        let img = UIImage(systemName: "plus")
//        DoneBut.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
//        DoneBut.setImage(img, for: .normal)
//        DoneBut.layer.cornerRadius = 25
//        DoneBut.backgroundColor = UIColor.white
//
//        DoneBut.translatesAutoresizingMaskIntoConstraints = false
//        DoneBut.addTarget(self, action: #selector(ff), for: .touchUpInside)
//        return DoneBut
//    }()
//
//    @objc func ff(){
//
//    }
    
    func setupViews(){
//        addSubview(newSetButton)
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
}
