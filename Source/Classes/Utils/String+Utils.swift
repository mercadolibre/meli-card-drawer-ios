internal extension String {
    
    func getFont(size: CGFloat = 16) -> UIFont {
        switch self {
        case "regular":
            return UIFont.systemFont(ofSize: size, weight: .regular)
        case "semi_bold":
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        case "light":
            return UIFont.systemFont(ofSize: size, weight: .light)
        case "bold":
            return UIFont.systemFont(ofSize: size, weight: .bold)
        default:
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
    }
    
    func replacingFirstOccurrence(of target: String, with replacement: String) -> String {
        guard let range = self.range(of: target) else { return self }
        return self.replacingCharacters(in: range, with: replacement)
    }
}

