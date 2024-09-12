import CoreData
import UIKit

class CoreDataService {
    static let shared = CoreDataService()
    
    func saveTodos(_ todos: [Todo]) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            
            todos.forEach { todo in
                // Проверяем, существует ли уже объект с таким id
                let fetchRequest: NSFetchRequest<ToDoItemEntity> = ToDoItemEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %d", todo.id)

                do {
                    let existingTodos = try context.fetch(fetchRequest)
                    
                    if existingTodos.isEmpty {
                        // Если нет существующих объектов, добавляем новый
                        let newTodo = ToDoItemEntity(context: context)
                        newTodo.id = Int32(todo.id)
                        newTodo.todo = todo.todo
                        newTodo.completed = todo.completed
                        newTodo.userId = Int32(todo.userId)
                    } else {
                        // Если объект уже существует, можно обновить его, если нужно
                    }
                } catch {
                    print("Failed to fetch todos: \(error)")
                }
            }
            
            // Сохраняем изменения
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    
    func fetchLocalTodos() -> [ToDoItemEntity] {
        // Логика загрузки данных из CoreData
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<ToDoItemEntity> = ToDoItemEntity.fetchRequest()
        
        do {
            let todos = try context.fetch(fetchRequest)
            return todos
        } catch {
            print("Failed to fetch todos: \(error)")
            return []
        }
    }
    
}
