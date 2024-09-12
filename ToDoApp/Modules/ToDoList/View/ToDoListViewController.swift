import UIKit
import SnapKit

class ToDoListViewController: UIViewController, ToDoListViewProtocol {
    var presenter: ToDoListPresenterProtocol?
    let todosTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 120
        tableView.backgroundColor = .clear
        return tableView
    }()
    var todos: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todosTableView.delegate = self
        todosTableView.dataSource = self
        title = "Main"
        addViews()
        setupUI()
        
        presenter?.viewDidLoad()
    }
    
    func addViews() {
        view.addSubview(todosTableView)
    }

    func setupUI() {
        todosTableView.snp.makeConstraints { (make) -> Void in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    func showTodos() {
        todosTableView.reloadData()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func displayTodos(_ todos: [Todo]) {
        self.todos = todos
        todosTableView.reloadData()
    }
}


extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoTableViewCell
        let todo = todos[indexPath.row]
        if todo.completed {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: todo.todo)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.todoLabel.attributedText = attributeString
            cell.todoLabel.textColor = .gray
            cell.checkmarkView.backgroundColor = .systemBlue
        } else {
            // Убираем зачеркнутый текст и возвращаем стандартное отображение
            cell.todoLabel.attributedText = nil // Сбрасываем атрибуты
            cell.todoLabel.text = todo.todo
            cell.todoLabel.textColor = .black
            cell.checkmarkView.backgroundColor = .clear
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todos[indexPath.row]
        let editToDoVC = EditToDoRouter.createEditToDoModule(todo: todo)
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(editToDoVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            // Удаление строки из модели данных
            self.todos.remove(at: indexPath.row) // Замените dataArray на вашу модель данных
            
            // Удаление строки из таблицы
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true // Опционально: настройка для полного свайпа
        return configuration
    }
}

extension ToDoListViewController: TodoTableViewCellDelegate {
    func didTapCheckmark(in cell: TodoTableViewCell) {
        guard let indexPath = todosTableView.indexPath(for: cell) else { return }
        
        todos[indexPath.row].completed.toggle()
        todosTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
