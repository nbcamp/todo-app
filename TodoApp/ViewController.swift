import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var completesButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.transform = CGAffineTransform(translationX: 0, y: 200)

        UIView.animate(
            withDuration: 1.0,
            delay: 0.2,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 10
        ) {
            self.titleLabel.transform = .identity
        }
    }
}
