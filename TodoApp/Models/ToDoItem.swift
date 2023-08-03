import Foundation

final class TodoItem {
    var id: String
    var content: String
    var createdAt: UInt
    var completedAt: UInt?

    var completed: Bool { completedAt != nil }

    init(content: String) {
        self.id = UUID().uuidString
        self.content = content
        self.createdAt = UInt(Date().timeIntervalSince1970)
    }
}
