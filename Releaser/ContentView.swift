
import SwiftUI
import Defaults

struct ContentView: View {

    @State private var selectedAppIndex: Int? = nil
    @State private var selectedReleaseIndex: Int? = nil
    
    @Default(.apps) var apps

    var body: some View {
        NavigationSplitView {
            appSidebar
        } detail: {
            if let selectedAppIndex, apps.count > 0 {
                ReleaseDetailView(app: $apps[selectedAppIndex])
                    .id($apps[selectedAppIndex].id)
            } else {
                Text("Select an app from the sidebar")
            }
        }
        .onAppear {
            if apps.count > 0 {
                selectedAppIndex = 0
            }
        }
    }
    
    var appSidebar: some View {
        List(selection: $selectedAppIndex) {
            if apps.count > 0 {
                ForEach(apps.indices, id: \.self) { index in
                    NavigationLink(value: apps[index]) {
                        Group {
                            if let imageUrl = apps[index].imageUrl, let savedImage = NSImage(contentsOf: imageUrl) {
                                Image(nsImage: savedImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                            } else {
                                RoundedRectangle(cornerRadius: 4, style: .continuous)
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(.secondary.opacity(0.2))
                            }
                        }
                        
                        TextField("App Name", text: $apps[index].name)
                            .contextMenu {
                                Button(role: .destructive) {
                                    if let index = apps.firstIndex(of: apps[index]) {
                                        withAnimation {
                                            apps.remove(at: index)
                                        }
                                    }
                                } label: {
                                    Text("Delete")
                                }
                            }
                    }
                }
            }
            
            Divider()
            
            Button {
                let newApp = Application(name: "New App", releases: [], id: UUID())
                apps.append(newApp)
                
                if apps.count == 1 {
                    selectedAppIndex = 0
                } else {
                    if let index = apps.firstIndex(of: newApp) {
                        selectedAppIndex = index
                    }
                }
            } label: {
                Text("Add New App")
            }
            .buttonStyle(.plain)
            
            Button {
                apps.removeAll()
            } label: {
                Text("Delete all")
            }

        }
        .listStyle(.sidebar)
    }
}
