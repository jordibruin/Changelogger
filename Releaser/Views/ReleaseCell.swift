struct ReleaseCell: View {
    
    @Binding var release: Release
    
    @State var edit = false
    @FocusState private var textfieldFocused: Bool
    
    var body: some View {
        NavigationLink {
            ReleaseDetailView(release: $release)
        } label: {
            HStack {
                if edit {
                    TextField("Version Number", text: $release.versionNumber)
                        .focused($textfieldFocused)
                } else {
                    Text(release.versionNumber)
                }
                
                Spacer()
                Button {
                    edit.toggle()
                    
                    if edit {
                        textfieldFocused = true
                    }
                } label: {
                    Image(systemName: "pencil.circle")
                }
                .buttonStyle(.plain)
            }
        }
    }
}