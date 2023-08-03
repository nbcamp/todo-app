import UIKit

final class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!

    var onCompleted: ((_: TodoTableViewCell) -> Void)?
    var completed: Bool = false {
        didSet {
            completeButton.isSelected = completed
            let attributedText = NSMutableAttributedString(string: todoLabel.text!)
            if completed {
                attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributedText.length))
                attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: CGColor.init(gray: 0.5, alpha: 1.0), range: NSMakeRange(0, attributedText.length))
            } else {
                attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle, value: [] as [Any], range: NSMakeRange(0, attributedText.length))
                attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: CGColor.init(gray: 0.0, alpha: 1.0), range: NSMakeRange(0, attributedText.length))
            }
            todoLabel.attributedText = attributedText
        }
    }

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        onCompleted?(self)
    }
}
