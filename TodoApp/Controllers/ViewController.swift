import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var completesButton: UIButton!

    var todoService = TodoService()
    var items: [TodoItem] { todoService.uncompletedItems }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        initializeUI()
    }

    func initializeUI() {
        titleLabel.text = "Todo List"
        tableView.backgroundView = {
            let label = UILabel()
            label.text = "Create New Todo Item!"
            label.textAlignment = .center
            label.textColor = .gray
            return label
        }()
        tableView.layer.opacity = 0.0
        completesButton.layer.opacity = 0.0
        titleLabel.transform = CGAffineTransform(translationX: 0, y: 200)

        UIView.animate(
            withDuration: 1.0,
            delay: 0.2,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 10
        ) {
            self.titleLabel.transform = .identity
        }

        UIView.animate(withDuration: 0.5, delay: 0.3) {
            self.tableView.layer.opacity = 1.0
            self.completesButton.layer.opacity = 1.0
        }

        tableView.separatorStyle = .none
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UIView.animate(withDuration: 0.2) {
            tableView.backgroundView?.layer.opacity = self.items.count > 0 ? 0.0 : 1.0
        }

        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoTableViewCell else {
            return UITableViewCell()
        }

        let item = items[indexPath.row]
        cell.todoLabel.text = item.content
        cell.selectionStyle = .none
        cell.onCompleted = { cell in
            self.todoService.toggle(id: item.id)
            cell.completed = item.completed
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            tableView.deleteRows(at: [indexPath], with: .top)
        }

        return cell
    }
}

extension ViewController: UITableViewDelegate {}
