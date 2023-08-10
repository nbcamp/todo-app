import UIKit

final class CompletesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let todoService = TodoService.shared
    var items: [TodoItem] { todoService.completedItems }
    var onDismissed: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        initializeUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        onDismissed?()
    }

    func initializeUI() {
        tableView.backgroundView = {
            let label = UILabel()
            label.text = "Complete Your Todo!"
            label.textAlignment = .center
            label.textColor = .gray
            return label
        }()
    }
}

extension CompletesViewController: UITableViewDataSource {
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
        cell.completed = item.completed
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
