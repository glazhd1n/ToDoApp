import Foundation
import UIKit

// MARK: - View
protocol ToDoListViewProtocol: AnyObject {
    func showTodos()
    func showError(message: String)
    func displayTodos(_ todos: [Todo])
}

protocol EditToDoViewProtocol: AnyObject {
    var presenter: EditToDoPresenterProtocol? { get set }
    func showToDoDetails(todo: Todo)
}

// MARK: - Interactor
protocol ToDoListInteractorInputProtocol: AnyObject {
    func fetchTodos()
    func fetchLocalTodos()
}

protocol ToDoListInteractorOutputProtocol: AnyObject {
    func didFetchTodosSuccessfully()
    func didFailToFetchTodos(with error: Error)
    func didFetchLocalTodos(_ todos: [Todo])
}

protocol EditToDoInteractorProtocol: AnyObject {
    var presenter: EditToDoInteractorOutputProtocol? { get set }
    func loadToDo()
    func updateToDo(title: String, completed: Bool)
}

protocol EditToDoInteractorOutputProtocol: AnyObject {
    func didLoadToDo(todo: Todo)
}


// MARK: - Presenter
protocol ToDoListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func reloadTodos()
}

protocol EditToDoPresenterProtocol: AnyObject {
    var view: EditToDoViewProtocol? { get set }
    var interactor: EditToDoInteractorProtocol? { get set }
    var router: EditToDoRouterProtocol? { get set }
    
    func viewDidLoad()
    func didTapSaveButton(title: String, completed: Bool)
}

// MARK: - Router
protocol ToDoListRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

protocol EditToDoRouterProtocol: AnyObject {
    func closeEditToDoScreen()
}
