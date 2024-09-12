import Foundation

class ToDoListPresenter: ToDoListPresenterProtocol, ToDoListInteractorOutputProtocol {
    weak var view: ToDoListViewProtocol?
    var interactor: ToDoListInteractorInputProtocol?
    var router: ToDoListRouterProtocol?

    func viewDidLoad() {
        interactor?.fetchLocalTodos()
    }

    func reloadTodos() {
        interactor?.fetchTodos()
    }
    
    func didFetchLocalTodos(_ todos: [Todo]) {
        // Здесь мы получаем данные из CoreData и передаем их на вью для отображения
        let todoModels = todos.map { todoEntity in
            Todo(id: Int(todoEntity.id), todo: todoEntity.todo, completed: todoEntity.completed, userId: Int(todoEntity.userId))
        }
        
        // Обновляем UI с помощью полученных локальных данных
        view?.displayTodos(todoModels)
    }
    
    func didFetchTodosSuccessfully() {
        view?.showTodos()
    }
    
    func didFailToFetchTodos(with error: Error) {
        view?.showError(message: "Failed to fetch todos: \(error.localizedDescription)")
    }
}
