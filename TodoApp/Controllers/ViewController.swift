import UIKit

class ViewController: UIViewController {
    var items: [ToDoItem] = [
        ToDoItem(content: "Navigation 기능 구현하기"),
        ToDoItem(content: "페이지 간 데이터 전달하기"),
        ToDoItem(content: "TableView 사용법 연습하기"),
    ]

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var completesButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        initializeUI()
    }

    func initializeUI() {
        titleLabel.text = "ToDo List"
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
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoCell else {
            return UITableViewCell()
        }

        cell.todoLabel.text = items[indexPath.row].content

        return cell
    }
}

extension ViewController: UITableViewDelegate {}
