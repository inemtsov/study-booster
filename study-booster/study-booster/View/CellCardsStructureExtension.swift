import Foundation
import UIKit

extension FlashcardCell{
    static func structure(cards: [Flashcard], cell: FlashcardCell, indexPath: IndexPath) -> FlashcardCell{
        cell.imageContainer.backgroundColor = nil
        cell.answerContainer.backgroundColor = nil
        cell.flashcardAnswer.text = nil
        cell.flashcardAnswer.text = cards[indexPath.row].question.count > 20 ? "\(cards[indexPath.row].question.prefix(20))..." : cards[indexPath.row].question
        var image: UIImage?
        var color: UIColor?
        switch cards[indexPath.row].difficulty {
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
