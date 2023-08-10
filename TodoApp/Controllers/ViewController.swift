import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var completesButton: UIButton!

    var todoService = TodoService.shared
    var items: [TodoItem] { todoService.uncompletedItems }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        initializeUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        newButton.layer.opacity = 0.0
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
            self.newButton.layer.opacity = 1.0
            self.completesButton.layer.opacity = 1.0
        }
    }

    @IBAction func newButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add New Todo Item", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Add", style: .default) { [weak alert] _ in
            let text = alert?.textFields?[0].text ?? ""
            if text.isEmpty { return }
            self.todoService.add(content: text)
            self.tableView.insertRows(at: [.init(row: self.items.count - 1, section: 0)], with: .automatic)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true)
        }
        alert.addTextField { $0.placeholder = "Write Here" }
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
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

        let index = indexPath.row
        let item = items[index]
        cell.todoLabel.text = item.content
        cell.completed = item.completed
        cell.selectionStyle = .none
        cell.onCompleted = { [weak self] cell in
            guard let self else { return }
            self.todoService.toggle(id: item.id)
            cell.completed = item.completed
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            tableView.deleteRows(at: [indexPath], with: .top)
        }
        cell.onLabelTapped = { [weak self] label in
            guard let self else { return }
            let alert = UIAlertController(title: "Edit Todo Item", message: nil, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Edit", style: .default) { [weak alert] _ in
                let text = alert?.textFields?[0].text ?? ""
                if text.isEmpty { return }
                label.text = text
                self.todoService.update(index: index, content: text)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                self.dismiss(animated: true)
            }
            alert.addTextField { $0.placeholder = label.text }
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }

        return cell
    }
}

extension ViewController: UITableViewDelegate {}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CompletesVC" {
            if let vc = segue.destination as? CompletesViewController {
                vc.onDismissed = {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
