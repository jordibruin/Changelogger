struct ApplicationDetailView: View {

    @Binding var app: Application

    var body: some View {
        NavigationSplitView {
            List {
                Button {
                    app.releases.append(Release(id: UUID(), versionNumber: "1.0", features: []))
                } label: {
                    Text("New version")
                }

                ForEach($app.releases) { $release in
                    ReleaseCell(release: $release)
                }
            }
            .listStyle(.sidebar)
        } detail: {
            Text("Select a version")
        }
    }
}