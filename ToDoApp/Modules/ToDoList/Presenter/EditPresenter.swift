class EditToDoPresenter: EditToDoPresenterProtocol {
    
    weak var view: EditToDoViewProtocol?
    var interactor: EditToDoInteractorProtocol?
    var router: EditToDoRouterProtocol?
    
    func viewDidLoad() {
        interactor?.loadToDo()
    }
    
    func didTapSaveButton(title: String, completed: Bool) {
        interactor?.updateToDo(title: title, completed: completed)
        router?.closeEditToDoScreen()
        
    }
}

extension EditToDoPresenter: EditToDoInteractorOutputProtocol {
    func didLoadToDo(todo: Todo) {
        view?.showToDoDetails(todo: todo)
    }
}
