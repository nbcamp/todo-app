import UIKit

final class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!

    var onCompleted: ((_: TodoTableViewCell) -> Void)?
    var completed: Bool = false {
        didSet {
            completeButton.isSelected = completed
            todoLabel.attributedText = NSAttributedString(
                string: todoLabel.text!,
                attributes: completed ? [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .foregroundColor: UIColor.darkGray
                ] : [:]
            )
        }
    }

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        onCompleted?(self)
    }
}
