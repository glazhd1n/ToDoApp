class EditToDoInteractor: EditToDoInteractorProtocol {
    weak var presenter: EditToDoInteractorOutputProtocol?

    private var todo: Todo
    
    init(todo: Todo) {
        self.todo = todo
    }

    func loadToDo() {
        // Отправляем ToDo презентеру
        presenter?.didLoadToDo(todo: todo)
    }
    
    func updateToDo(title: String, completed: Bool) {
        todo.todo = title
        todo.completed = completed
        // Здесь можно обновить данные в базе данных или через API
    }
}
