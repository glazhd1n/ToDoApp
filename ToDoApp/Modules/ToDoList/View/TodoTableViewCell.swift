//
//  TodoTableViewCell.swift
//  ToDoApp
//
//  Created by Сабир Глаждин on 09.09.2024.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    weak var delegate: TodoTableViewCellDelegate?
    var todoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    let checkmarkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemBlue.cgColor
        
        let checkmarkImageView = UIImageView(image: UIImage(systemName: "checkmark"))
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkmarkImageView.tintColor = .white
        
        view.addSubview(checkmarkImageView)
        view.backgroundColor = .systemBlue
        
        // Centering the checkmark inside the circle
        checkmarkImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(todoLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(checkmarkView)
        
        
        setupConstraints()
        setupCheckmarkTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func configure(with todo: Todo) {
        todoLabel.text = todo.todo
        
        if todo.completed {
            let attributedString = NSMutableAttributedString(string: todo.todo)
            attributedString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: attributedString.length))
            todoLabel.attributedText = attributedString
            checkmarkView.backgroundColor = .systemBlue
        } else {
            todoLabel.attributedText = nil
            todoLabel.text = todo.todo
            todoLabel.textColor = .black
            checkmarkView.backgroundColor = .clear
        }
    }
    
    
    private func setupCheckmarkTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckmark))
        checkmarkView.addGestureRecognizer(tapGesture)
        checkmarkView.isUserInteractionEnabled = true
    }
    
    @objc private func didTapCheckmark() {
        delegate?.didTapCheckmark(in: self)
    }
    
    private func setupConstraints() {
        todoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(checkmarkView.snp.leading).offset(-8)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(todoLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-12)
            make.trailing.equalTo(checkmarkView.snp.leading).offset(-8)
        }
        
        checkmarkView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
    }

}
