import Foundation
import UIKit

final class HabitCreatingVC: UIViewController {
    // MARK: - Private properties:
    private let titlesForRows: [String] = ["Категория", "Расписание"]
    private let stackView = UIStackView()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let emojies: [String] = ["🙂", "😻", "🌺", "🐶", "❤️", "😱",
                                     "😇", "😡", "🥶", "🤔", "🙌", "🍔",
                                     "🥦", "🏓", "🥇", "🎸", "🏝️", "😪"]
    private let colors: [UIColor] = [
        .YPColorSelection1, .YPColorSelection2, .YPColorSelection3,
        .YPColorSelection4, .YPColorSelection5, .YPColorSelection6,
        .YPColorSelection7, .YPColorSelection8, .YPColorSelection9,
        .YPColorSelection10, .YPColorSelection11, .YPColorSelection12,
        .YPColorSelection13, .YPColorSelection14, .YPColorSelection15,
        .YPColorSelection16, .YPColorSelection17, .YPColorSelection18
    ]
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = "Новая привычка"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .YPBlack
        
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отменить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .YPRed
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.YPRed.cgColor
        
        return button
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cоздать", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .YPWhite
        button.backgroundColor = .YPGray
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        
        return button
    }()
    
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        view.backgroundColor = .YPWhite
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        configureTitleAndCollectionView()
        configureSupplementaryView()
        configureStackViewAndButtons()
    }
    
    // MARK: - Private methods:
    private func configureTitleAndCollectionView() {
        topTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topTitle)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        collectionView.register(TextFieldCell.self, forCellWithReuseIdentifier: TextFieldCell.reuseIdentifier)
        collectionView.register(ButtonsCell.self, forCellWithReuseIdentifier: ButtonsCell.reuseIdentifier)
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: EmojiCell.reuseIdentifier)
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.reuseIdentifier)
        
        collectionView.showsVerticalScrollIndicator = false
        
        
        NSLayoutConstraint.activate([
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39),
            topTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            topTitle.heightAnchor.constraint(equalToConstant: 22),
            topTitle.widthAnchor.constraint(equalToConstant: 149),
            
            collectionView.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: 38),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])
    }
    
    private func configureStackViewAndButtons() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(createButton)
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34),
            
            cancelButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 166),
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            
            createButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 161),
            createButton.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    
    private func configureSupplementaryView() {
        collectionView.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SupplementaryView.reuseIdentifier)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout:
extension HabitCreatingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case sections.textfieldCell.rawValue:
            return CGSize(width: collectionView.bounds.width, height: 75)
        case sections.buttonsCell.rawValue:
            return CGSize(width: collectionView.bounds.width, height: 75)
        case sections.emojiCell.rawValue:
            return CGSize(width: collectionView.bounds.width / 7, height: 52)
        case sections.colorCell.rawValue:
            return CGSize(width: collectionView.bounds.width / 7, height: 52)
        default: return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case sections.textfieldCell.rawValue:
            return 0
        case sections.buttonsCell.rawValue:
            return 0
        case sections.emojiCell.rawValue:
            return 5
        case sections.colorCell.rawValue:
            return 5
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case sections.buttonsCell.rawValue:
            return 0
        case sections.emojiCell.rawValue:
            return 0
        case sections.colorCell.rawValue:
            return 0
        default: return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case sections.buttonsCell.rawValue:
            return CGSize(width: 1, height: 24)
        case sections.emojiCell.rawValue:
            return CGSize(width: collectionView.bounds.width, height: 50)
        case sections.colorCell.rawValue:
            return CGSize(width: collectionView.bounds.width, height: 34)
            
        default: return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case sections.emojiCell.rawValue:
            return UIEdgeInsets(top: 24, left: 2, bottom: 24, right: 2)
        case sections.colorCell.rawValue:
            return UIEdgeInsets(top: 24, left: 2, bottom: 24, right: 2)
        default:
            return UIEdgeInsets()
        }
    }
    
    
}

// MARK: - UITableViewDataSource:
extension HabitCreatingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case sections.textfieldCell.rawValue: return 1
        case sections.buttonsCell.rawValue: return 2
        case sections.emojiCell.rawValue: return emojies.count
        case sections.colorCell.rawValue: return colors.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case sections.textfieldCell.rawValue:
            guard let textFieldCell = collectionView.dequeueReusableCell(withReuseIdentifier: TextFieldCell.reuseIdentifier, for: indexPath) as? TextFieldCell else {
                print("Couldn't create textfieldCell")
                return UICollectionViewCell()
            }
            textFieldCell.backgroundColor = .YPBackground
            textFieldCell.textField.textColor = .YPBlack
            textFieldCell.layer.masksToBounds = true
            textFieldCell.layer.cornerRadius = 16
            return textFieldCell
            
        case sections.buttonsCell.rawValue:
            guard let buttonsCell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCell.reuseIdentifier, for: indexPath) as? ButtonsCell else {
                print("Couldn't create buttonsCell")
                return UICollectionViewCell()
            }
            buttonsCell.label.text = titlesForRows[indexPath.row]
            return buttonsCell
            
        case sections.emojiCell.rawValue:
            guard let emojiCell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseIdentifier, for: indexPath) as? EmojiCell else {
                print("Couldn't create emojiCell")
                return UICollectionViewCell()
            }
            emojiCell.emojiLabel.text = emojies[indexPath.row]
            emojiCell.emojiLabel.font = .systemFont(ofSize: 32)
            return emojiCell
            
        case sections.colorCell.rawValue:
            guard let colorCell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.reuseIdentifier, for: indexPath) as? ColorCell else {
                print("Couldn't create colorCell")
                return UICollectionViewCell()
            }
            colorCell.colorView.backgroundColor = colors[indexPath.row]
            return colorCell
            
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case sections.emojiCell.rawValue:
            let emojiHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SupplementaryView.reuseIdentifier, for: indexPath) as! SupplementaryView
            emojiHeaderView.titleLabel.text = "Emoji"
            return emojiHeaderView
            
        case sections.colorCell.rawValue:
            let colorHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SupplementaryView.reuseIdentifier, for: indexPath) as! SupplementaryView
            colorHeaderView.titleLabel.text = "Цвет"
            return colorHeaderView
            
        default:
            return UICollectionReusableView()
        }
    }
    
}

// MARK: - UICollectionViewDelegate:
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case sections.buttonsCell.rawValue:
            let buttonCell = collectionView.cellForItem(at: indexPath) as? ButtonsCell
            buttonCell?.backgroundColor = .darkGray
            print("DidSelect was called")
        case sections.emojiCell.rawValue:
            let emojiCell = collectionView.cellForItem(at: indexPath) as? EmojiCell
            emojiCell?.layer.masksToBounds = true
            emojiCell?.layer.cornerRadius = 16
            emojiCell?.layer.backgroundColor = UIColor.YPLightGray.cgColor
        case sections.colorCell.rawValue:
            let colorCell = collectionView.cellForItem(at: indexPath) as? ColorCell
            colorCell?.layer.masksToBounds = true
            colorCell?.layer.borderWidth = 2
            colorCell?.layer.borderColor = colorCell?.colorView.backgroundColor?.cgColor
        default:
            break
        }
    }
}
