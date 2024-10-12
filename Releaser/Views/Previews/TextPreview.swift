//
//  TextPreview.swift
//  Changelogger
//
//  Created by Jordi Bruin on 11/10/2024.
//

import SwiftUI

struct TextPreview: View {
    
    let release: Release
    let previewMode: PreviewMode
    @State var releaseNotesText = ""
    
    var body: some View {
        ZStack {
            Color.primary.opacity(0.05)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            TextEditor(text: .constant(release.normalText))
                .scrollContentBackground(.hidden)
                .padding(8)
        }
    }
}
