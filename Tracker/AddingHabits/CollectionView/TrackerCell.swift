import UIKit

class TrackerCell: UICollectionViewCell {
    // MARK: - Properties:
    static let reuseID = "TrackersCell"
    
    // MARK: - Private properties:
    var numberOfCompletedDays: Int = 0
    private var trackerID: UUID? = nil
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .YPBlue
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .YPBackground
        label.font = .systemFont(ofSize: 16)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 14
        label.textAlignment = .center
        label.text = "😍"
        
        
        return label
    }()
    
    private lazy var trackerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.text = "Learn swift"
        label.textColor = .YPWhite
        
        return label
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var daysCounterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .YPBlack
        label.text = "\(numberOfCompletedDays.days())"
        
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Plus"), for: .normal)
        button.tintColor = .YPWhite
        button.imageEdgeInsets = UIEdgeInsets(top: 11.72, left: 11.72, bottom: 12.07, right: 11.65)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 17
        button.backgroundColor = topView.backgroundColor
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Methods:
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(id: UUID,
                    name: String,
                    color: UIColor,
                    emoji: String,
                    isCompleted: Bool,
                    completedDays: Int) {
        trackerID = id
        trackerNameLabel.text = name
        topView.backgroundColor = color
        emojiLabel.text = emoji
        plusButton.backgroundColor = color
        numberOfCompletedDays = completedDays
        daysCounterLabel.text = "\(numberOfCompletedDays.days())"
    }
    // MARK: - Private methods:
    @objc private func plusButtonTapped() {
        let plusImage = UIImage(named: "Plus")
        let doneImage = UIImage(named: "Checkmark")
    
        if plusButton.currentImage != doneImage {
            plusButton.setImage(doneImage, for: .normal)
            plusButton.imageEdgeInsets = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
            plusButton.tintColor = .YPWhite
            numberOfCompletedDays += 1
            daysCounterLabel.text = "\(numberOfCompletedDays.days())"
        } else {
            plusButton.setImage(plusImage, for: .normal)
            plusButton.imageEdgeInsets = UIEdgeInsets(top: 11.72, left: 11.72, bottom: 12.07, right: 11.65)
            plusButton.tintColor = .YPWhite
            numberOfCompletedDays -= 1
            daysCounterLabel.text = "\(numberOfCompletedDays.days())"
        }
    }
    
    private func configureCell() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        trackerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        daysCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(topView)
        contentView.addSubview(bottomView)
        topView.addSubview(emojiLabel)
        topView.addSubview(trackerNameLabel)
        bottomView.addSubview(daysCounterLabel)
        bottomView.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topView.widthAnchor.constraint(equalToConstant: 167),
            topView.heightAnchor.constraint(equalToConstant: 90),
            emojiLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 12),
            emojiLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 12),
            emojiLabel.heightAnchor.constraint(equalToConstant: 28),
            emojiLabel.widthAnchor.constraint(equalToConstant: 28),
            trackerNameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 44),
            trackerNameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -12),
            trackerNameLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 12),
            trackerNameLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -12),
            
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomView.widthAnchor.constraint(equalToConstant: 167),
            bottomView.heightAnchor.constraint(equalToConstant: 58),
            daysCounterLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            daysCounterLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 12),
            daysCounterLabel.widthAnchor.constraint(equalToConstant: 101),
            daysCounterLabel.heightAnchor.constraint(equalToConstant: 18),
            
            plusButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 8),
            plusButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -12),
            plusButton.widthAnchor.constraint(equalToConstant: 34),
            plusButton.heightAnchor.constraint(equalToConstant: 34)
        ])
        
    }
}
