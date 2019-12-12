import Foundation
import UIKit

extension SubjectCell{
    static func structure(subjects: [Subject], cell: SubjectCell, indexPath: IndexPath) -> SubjectCell{
        cell.titleContainer.backgroundColor = nil
        cell.descriptionContainer.backgroundColor = nil
        cell.subjectTitle.text = nil
        cell.subjectDescription.text = nil
        cell.subjectTitle.text = subjects[indexPath.row].title
        cell.subjectDescription.text = subjects[indexPath.row].description.count > 20 ? "\(subjects[indexPath.row].description.prefix(20))..." : subjects[indexPath.row].description
        
        if(indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor(hexString: "#DCDCDC")
            cell.imageContainer.tintColor = UIColor.white
        }
        return cell
    }
}
