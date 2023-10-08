import Foundation
import UIKit

final class CustomUITextField: UITextField {
    // MARK: - Properties:
    let insets: UIEdgeInsets
    // MARK: - Initializers:
    init(insets: UIEdgeInsets, placeholder text: String) {
        self.insets = insets
        super.init(frame: .zero)
        
        placeholder = text
        clearButtonMode = .whileEditing
        textColor = .YPBlack
        font = .systemFont(ofSize: 16, weight: .medium)
        layer.masksToBounds = true
        layer.cornerRadius = 16
        backgroundColor = .YPBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Insets:
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 0, left: 314, bottom: 0, right: 0))
    }
}
