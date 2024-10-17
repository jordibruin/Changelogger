//
//  ScreenshotBackground.swift
//  Changelogger
//
//  Created by Jordi Bruin on 12/10/2024.
//

import SwiftUI

enum ScreenshotBackground: String, Identifiable, CaseIterable {
    case blue
    case green
    case red
    case sonomaLight
    case sonomaDark
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
        case .sonomaDark, .sonomaLight:
            Color.white
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
    
    var image: Image? {
        switch self {
        case .sonomaDark:
            Image("sonoma-dark")
        case .sonomaLight:
            Image("sonoma-light")
        default:
            nil
        }
    }
}
