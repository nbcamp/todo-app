import UIKit

final class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!

    var onCompleted: ((_: TodoTableViewCell) -> Void)?
    var onLabelTapped: ((_: UILabel) -> Void)?
    var completed: Bool = false {
        didSet {
            completeButton.isSelected = completed
            let attributedText = NSMutableAttributedString(string: todoLabel.text!)
            if completed {
                attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributedText.length))
                attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: CGColor(gray: 0.5, alpha: 1.0), range: NSMakeRange(0, attributedText.length))
            } else {
                attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle, value: [] as [Any], range: NSMakeRange(0, attributedText.length))
                attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: CGColor(gray: 0.0, alpha: 1.0), range: NSMakeRange(0, attributedText.length))
            }
            todoLabel.attributedText = attributedText
        }
    }

    override func didMoveToSuperview() {
        initializeUI()
    }

    private func initializeUI() {
        setupGesture()
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        todoLabel.isUserInteractionEnabled = true
        todoLabel.addGestureRecognizer(tapGesture)
    }

    @objc
    private func labelTapped() {
        onLabelTapped?(todoLabel)
    }

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        onCompleted?(self)
    }
}
