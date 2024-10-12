//
//  NormalTextPreview.swift
//  Changelogger
//
//  Created by Jordi Bruin on 11/10/2024.
//

import SwiftUI

struct NormalTextPreview: View {
    
    let release: Release
    @State var releaseNotesText = ""
    
    var body: some View {
        TextEditor(text: .constant(release.normalText))
            .scrollContentBackground(.hidden)
            .padding(8)
    }
}
