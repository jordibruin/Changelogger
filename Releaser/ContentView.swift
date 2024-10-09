////
////  ContentView.swift
////  Releaser
////
////  Created by Jordi Bruin on 29/09/2024.
////
//
//import SwiftUI
//import Defaults
//
struct NormalTextPreview: View {
    
    let release: Release
    @State var releaseNotesText = ""
    
    var body: some View {
        TextEditor(text: .constant(release.normalText))
            .scrollContentBackground(.hidden)
            .padding(8)
    }
}

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

import WebKit

struct HTMLView: NSViewRepresentable {
    let htmlContent: String

    func makeNSView(context: Context) -> WKWebView {
        
        let view = WKWebView()
        view.loadHTMLString(htmlContent, baseURL: nil)
        return WKWebView()
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
import SwiftUI
import Defaults

struct ContentView: View {

    @Default(.apps) var apps

    var body: some View {

        NavigationStack {
            NavigationSplitView {
                List {
                    ForEach($apps) { $app in
                        AppNameCell(app: $app)
                    }
                }
                .listStyle(.sidebar)
            } detail: {
                VStack {
                    if apps.isEmpty {
                        Button {
                            apps.append(Application(name: "App Name", releases: [], id: UUID()))
                        } label: {
                            Text("Create new app")
                        }

                    } else {
                        Text("Select an app")
                    }
                }
            }
        }
        .onAppear {
            
        }
    }
}

struct AppNameCell: View {
    
    @Binding var app: Application
    @State var edit = false
    
    @FocusState private var textfieldFocused: Bool
    
    var body: some View {
        NavigationLink {
            ApplicationDetailView(app: $app)
        } label: {
            HStack {
                if edit {
                    TextField("App Name", text: $app.name)
                        .focused($textfieldFocused)
                } else {
                    Text(app.name)
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
