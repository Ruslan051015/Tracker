import Foundation
import UIKit

final class ButtonsCell: UICollectionViewCell {
    // MARK: - Properties:
    static let reuseIdentifier = "SecondSectionCell"
    // MARK: - Private properties:
    lazy var label: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        title.textColor = .YPBlack
        title.backgroundColor = .clear
        return title
    }()
    
    // MARK: - Methods:
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 41),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -26)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
