import Foundation
import UIKit

final class TextFieldCell: UITableViewCell {
    // MARK: - Properties:
    static let reuseIdentifier: String = "FieldTableViewCell"
    
    // MARK: - Private properties:
    private lazy var textField: CustomUITextField = {
        let field = CustomUITextField(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 41), placeholder: "Введите название трекера")
        
        return field
    }()
    
    // MARK: - LifeCycle:
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Methods:
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

