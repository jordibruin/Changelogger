enum ScreenshotBackground: String, Identifiable, CaseIterable {
    case blue
    case green
    case red
    //    case custom
    
    var id: String { self.rawValue }
    
    var color: Color {
        switch self {
        case .blue:
            Color.blue
        case .green:
            Color.green
        case .red:
            Color.red
        }
    }
    
    var gradient: LinearGradient {
        LinearGradient(
            colors: [
                self.color,
                self.color.opacity(0.8)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
