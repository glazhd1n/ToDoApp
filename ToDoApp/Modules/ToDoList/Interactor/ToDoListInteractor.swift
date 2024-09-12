import Foundation

class ToDoListInteractor: ToDoListInteractorInputProtocol {
    weak var presenter: ToDoListInteractorOutputProtocol?
    
    private let apiService = APIService.shared
    private let coreDataService = CoreDataService.shared

    func fetchTodos() {
        apiService.fetchTodos { [weak self] result in
            switch result {
            case .success(let todos):
                // Логика для сохранения данных в CoreData
                self?.coreDataService.saveTodos(todos)
                self?.presenter?.didFetchTodosSuccessfully()
            case .failure(let error):
                self?.presenter?.didFailToFetchTodos(with: error)
            }
        }
    }

    func fetchLocalTodos() {
        // Логика загрузки данных из CoreData
        let todoEntities = coreDataService.fetchLocalTodos()
        
        // Преобразование ToDoItemEntity в ToDoItemModel
        let todos = todoEntities.map { entity in
            Todo(
                id: Int(entity.id),
                todo: entity.todo!,
                completed: entity.completed,
                userId: Int(entity.userId)
            )
        }
        print(todos)
        presenter?.didFetchLocalTodos(todos)
    }
}
