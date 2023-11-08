import Foundation
import UIKit

final class EmojiCell: UICollectionViewCell {
    // MARK: - Properties:
    static let reuseIdentifier = "EmojiCell"
    let emojiLabel = UILabel()
  
    // MARK: - Methods:
    override init(frame: CGRect) {
        super.init(frame: frame)
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false

        emojiLabel.font = .systemFont(ofSize: 32)
        contentView.addSubview(emojiLabel)
        
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
