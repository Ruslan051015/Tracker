import Foundation

extension String {
    enum Source: String {
        case target = "Localizible"
    }
    
    func localized(
        from source: Source = .target,
        _ bundle: Bundle = Bundle.main,
        _ comment: String = "") -> String {
            return NSLocalizedString(
                self,
                tableName: source.rawValue,
                bundle: bundle,
                value: notFoundValue,
                comment: comment)
        }
    
}
