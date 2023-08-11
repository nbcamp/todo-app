import Foundation

final class TodoService {
    static var shared: TodoService = .init()
    private init() {}

    private(set) var items: [TodoItem] = [
        TodoItem(content: "New를 눌러 새로운 항목을 추가해보세요!"),
        TodoItem(content: "여기를 눌러 할 일 내용을 변경해보세요!"),
        TodoItem(content: "체크박스를 눌러 할 일을 완료해보세요!"),
        TodoItem(content: "Completes를 눌러 완료 내역을 확인하세요!"),
    ]

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
