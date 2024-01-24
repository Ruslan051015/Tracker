import UIKit

class FiltersTableViewCell: UITableViewCell {
    // MARK: - Properties:
    static let reuseID = "FiltersCellID"
    
    // MARK: - Private properties:
    private lazy var cellTitleLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 17, weight: .regular)
        title.textColor = .YPBlue
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    private lazy var checkMark: UIImageView = {
        let image = UIImage(named: "checkmark")
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - LifeCycle:
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods:
    func configureCell(filtersName: String, checkmarkStatus: Bool) {
        cellTitleLabel.text = filtersName
        checkMark.isHidden = checkmarkStatus
    }
    
    func setCheckMark(isHiden: Bool) {
        checkMark.isHidden = isHiden
    }
    
    // MARK: - Private Methods:
    private func configureCellUI() {
        contentView.addSubview(cellTitleLabel)
        contentView.addSubview(checkMark)
        
        NSLayoutConstraint.activate([
            cellTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            checkMark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkMark.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkMark.heightAnchor.constraint(equalToConstant: 24),
            checkMark.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}
