import UIKit
import SnapKit

class EditToDoView: UIViewController, EditToDoViewProtocol {
    
    var presenter: EditToDoPresenterProtocol?

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter todo title"
        return textField
    }()
    
    private let completedSwitch: UISwitch = {
        let switchControl = UISwitch()
        return switchControl
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleTextField)
        view.addSubview(completedSwitch)
        view.addSubview(saveButton)
        setupConstraints()

        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        presenter?.viewDidLoad()
    }

    func setupConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        completedSwitch.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(completedSwitch.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(120)
        }
    }
    
    func showToDoDetails(todo: Todo) {
        titleTextField.text = todo.todo
        completedSwitch.isOn = todo.completed
    }

    @objc func saveButtonTapped() {
        guard let title = titleTextField.text else { return }
        presenter?.didTapSaveButton(title: title, completed: completedSwitch.isOn)
    }
}
