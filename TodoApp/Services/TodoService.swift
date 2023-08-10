import Foundation

final class TodoService {
    static var shared: TodoService = .init()
    private init() {}

    private(set) var items: [TodoItem] = [
        TodoItem(content: "Navigation 기능 구현하기"),
        TodoItem(content: "페이지 간 데이터 전달하기"),
        TodoItem(content: "TableView 사용법 연습하기"),
    ]

    var uncompletedItems: [TodoItem] { items.filter { !$0.completed } }
    var completedItems: [TodoItem] { items.filter { $0.completed } }

    func add(content: String) {
        items.append(TodoItem(content: content))
    }

    func update(index: Int, content: String) {
        items[index].content = content
    }

    func toggle(id: String) {
        guard let item = (items.first { $0.id == id }) else { return }

        item.completedAt = item.completed ? nil : UInt(Date().timeIntervalSince1970)
    }
}
