import Foundation

struct ToDoItem {
    var content: String
    var completedAt: UInt?
    
    init(content: String) {
        self.content = content
    }
}
