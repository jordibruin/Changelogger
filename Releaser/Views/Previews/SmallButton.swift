//
//
//  SmallButton.swift
//
//
//  Created by Ian Dundas on 03/04/2023.
//

import Foundation
import SwiftUI

public enum KeyboardShortcutModifier: String {
    case command = "⌘"
    case shift = "⇧"
    case control = "^"
    case option = "⌥"
}

public struct SmallButton: View {
    
    public enum IconPlacement {
        case leading
        case trailing
    }
    
    
    public var action : () -> ()
    let title: LocalizedStringKey
    var icon = ""
    var iconPlacement: IconPlacement
    let helpText: LocalizedStringKey
    let tintColor: Color
    let symbolColor: Color?
    
    let keyboardShortcutModifier: KeyboardShortcutModifier?
    let keyboardshortcutString: String?
    
    let minWidth: CGFloat?
    let fullColor: Bool
    
    public init(
        action: @escaping () -> (),
        title: LocalizedStringKey,
        icon: String = "",
        iconPlacement: IconPlacement = .leading,
        helpText: LocalizedStringKey,
        tintColor: Color,
        symbolColor: Color? = nil,
        keyboardShortcutModifier: KeyboardShortcutModifier? = nil,
        keyboardshortcutString: String? = nil,
        minWidth: CGFloat? = nil,
        fullColor: Bool? = false
    ) {
        self.action = action
        self.title = title
        self.icon = icon
        self.iconPlacement = iconPlacement
        self.helpText = helpText
        self.tintColor = tintColor
        self.symbolColor = symbolColor
        
        self.keyboardShortcutModifier = keyboardShortcutModifier
        self.keyboardshortcutString = keyboardshortcutString
        
        self.minWidth = minWidth
        self.fullColor = fullColor ?? false
    }
    
    @State private var isHovering : Bool = false
    
    public var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 3) {
                if icon.isEmpty == false && iconPlacement == .leading && keyboardshortcutString == nil {
                    Image(systemName: icon)
                        .foregroundColor(symbolColor ?? .primary)
                }
                
                Text(title)
                    .foregroundColor(textColor)
                    .offset(y: -0.5)
                
                if icon.isEmpty == false && iconPlacement == .trailing {
                    Image(systemName: icon)
                        .foregroundColor(symbolColor ?? .primary)
                }
                
                
                if let keyboardShortcutModifier {
                    ZStack {
                        Color.primary.opacity(0.07)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .frame(width: 22, height: 22)
                        
                        Text(keyboardShortcutModifier.rawValue)
                            .fontWeight(.medium)
                            .opacity(0.7)
                    }
                    .padding(.leading, 2)
                }
                
                if let keyboardshortcutString {
                    ZStack {
                        Color.primary.opacity(0.07)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .frame(width: 22, height: 22)
                        
                        Text(keyboardshortcutString)
                            .fontWeight(.medium)
                            .opacity(0.7)
                    }
                    .padding(.leading, 2)
                }
            }
            .padding(.leading, 10)
            .padding(.trailing, icon.isEmpty ? 10 : 6)
            .padding(.vertical, 6)
            .frame(minHeight: 32)
            .frame(minWidth: minWidth ?? 0)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .font(.system(.headline, design: .rounded).weight(.semibold))
        .foregroundColor(isHovering ? .primary : .secondary)
        .background(fullColor ? tintColor.opacity(0.9) : isHovering ? tintColor.opacity(0.1) : tintColor.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
        .help(helpText)
        .onHover { hover in
            withAnimation(.easeIn(duration: 0.25)) {
                isHovering = hover
            }
        }
    }
    
    
    var textColor: Color {
        if tintColor == .white {
            .primary
        } else {
            fullColor ? .white : tintColor
        }
    }
}


public struct WhiteSmallButton: View {
    
    public init(action: @escaping () -> (), title: LocalizedStringKey, icon: String = "", helpText: LocalizedStringKey, tintColor: Color, symbolColor: Color? = nil) {
        self.action = action
        self.title = title
        self.icon = icon
        self.helpText = helpText
        self.tintColor = tintColor
        self.symbolColor = symbolColor
    }
    
    public var action : () -> ()
    let title: LocalizedStringKey
    var icon = ""
    let helpText: LocalizedStringKey
    let tintColor: Color
    let symbolColor: Color?
    
    @State private var isHovering : Bool = false
    
    public var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 3) {
                if icon.isEmpty == false {
                    Image(systemName: icon)
                        .foregroundColor(symbolColor ?? .primary)
                }
                Text(title)
                    .foregroundColor(.blue)
//                    .foregroundColor(tintColor)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .frame(minHeight: 32)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .font(.system(.headline, design: .rounded).weight(.semibold))
        .foregroundColor(isHovering ? .primary : .secondary)
        .background(isHovering ? tintColor.opacity(0.9) : tintColor.opacity(1))
        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
        .help(helpText)
        .onHover { hover in
            withAnimation(.easeIn(duration: 0.25)) {
                isHovering = hover
            }
        }
    }
}


struct TestView: View {
    var body: some View {
        SmallButton(action: {
            
        }, title: "Back", helpText: "test", tintColor: .blue)
    }
}

#Preview(body: {
    TestView()
})

public struct GlobalSmallButton: View {
    
    public enum IconPlacement {
        case leading
        case trailing
    }
    
    
    public var action : () -> ()
    let title: LocalizedStringKey
    var icon = ""
    var iconPlacement: IconPlacement
    let helpText: LocalizedStringKey
    let tintColor: Color
    let symbolColor: Color?
    
    let keyboardShortcutModifier: KeyboardShortcutModifier?
    let keyboardshortcutString: String?
    
    public init(
        action: @escaping () -> (),
        title: LocalizedStringKey,
        icon: String = "",
        iconPlacement: IconPlacement = .leading,
        helpText: LocalizedStringKey,
        tintColor: Color,
        symbolColor: Color? = nil,
        
        keyboardShortcutModifier: KeyboardShortcutModifier? = nil,
        keyboardshortcutString: String? = nil
    ) {
        self.action = action
        self.title = title
        self.icon = icon
        self.iconPlacement = iconPlacement
        self.helpText = helpText
        self.tintColor = tintColor
        self.symbolColor = symbolColor
        
        self.keyboardShortcutModifier = keyboardShortcutModifier
        self.keyboardshortcutString = keyboardshortcutString
    }
    
    @State private var isHovering : Bool = false
    
    public var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 3) {
                if icon.isEmpty == false && iconPlacement == .leading && keyboardshortcutString == nil {
                    Image(systemName: icon)
                        .foregroundColor(symbolColor ?? .primary)
                }
                
                Text(title)
                    .foregroundColor(tintColor)
                    .offset(y: -0.5)
                
                if icon.isEmpty == false && iconPlacement == .trailing {
                    Image(systemName: icon)
                        .foregroundColor(symbolColor ?? .primary)
                }
                
                if let keyboardShortcutModifier {
                    ZStack {
                        Color.primary.opacity(0.07)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .frame(width: 20, height: 18)
                        
                        Text(keyboardShortcutModifier.rawValue)
                            .font(.caption)
                            .opacity(0.7)
                    }
                    .padding(.leading, 2)
                }
                
                if let keyboardshortcutString {
                    ZStack {
                        // Correct opacity
                        Color.primary.opacity(0.07)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .frame(width: 20, height: 18)
                        
                        Text(keyboardshortcutString)
                            .font(.caption)
                            .opacity(0.7)
                    }
                    .padding(.leading, 2)
                }
            }
            .font(.subheadline)
            .bold()
            .padding(.leading, 8)
            .padding(.trailing, 4)
            .padding(.vertical, 4)
            .frame(minHeight: 28)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .font(.system(.headline, design: .rounded).weight(.semibold))
        .foregroundColor(isHovering ? .primary : .secondary)
        .background(isHovering ? tintColor.opacity(0.1) : tintColor.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
        .help(helpText)
        .onHover { hover in
            withAnimation(.easeIn(duration: 0.25)) {
                isHovering = hover
            }
        }
    }
}
