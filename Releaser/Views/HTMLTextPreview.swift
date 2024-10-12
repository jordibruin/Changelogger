
struct HTMLTextPreview: View {
    
    let release: Release
    @State var releaseNotesText = ""
    
    var body: some View {
        ZStack {
            Color.primary.opacity(0.05)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            TextEditor(text: .constant(release.htmlText))
                .scrollContentBackground(.hidden)
                .padding(8)
        }
    }
}