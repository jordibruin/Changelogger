struct NormalTextPreview: View {
    
    let release: Release
    @State var releaseNotesText = ""
    
    var body: some View {
        TextEditor(text: .constant(release.normalText))
            .scrollContentBackground(.hidden)
            .padding(8)
    }
}
