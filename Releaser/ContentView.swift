//
//  ContentView.swift
//  Releaser
//
//  Created by Jordi Bruin on 29/09/2024.
//

import SwiftUI

struct Release: Identifiable {
    let id: UUID
    var features: [Feature]
    
    var normalText: String {
        var text = ""
        
        if !release.features.filter({ $0.tag == .new }).isEmpty {
            text = "New: \n"
            
            let newFeatures = release.features.filter({ $0.tag == .new })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        if !release.features.filter({ $0.tag == .improvement }).isEmpty {
            text = text +  "\n\nImprovements: \n"
            
            let newFeatures = release.features.filter({ $0.tag == .improvement })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        
        if !release.features.filter({ $0.tag == .bugfix }).isEmpty {
            text = text + "\n\nBugfixes: \n"
            
            let newFeatures = release.features.filter({ $0.tag == .bugfix })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        return text
    }
    
    var htmlText: String {
        var text = "<h1><ul>"
        
        if !release.features.filter({ $0.tag == .new }).isEmpty {
            text = "New: \n"
            
            let newFeatures = release.features.filter({ $0.tag == .new })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        if !release.features.filter({ $0.tag == .improvement }).isEmpty {
            text = text +  "\n\nImprovements: \n"
            
            let newFeatures = release.features.filter({ $0.tag == .improvement })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        
        if !release.features.filter({ $0.tag == .bugfix }).isEmpty {
            text = text + "\n\nBugfixes: \n"
            
            let newFeatures = release.features.filter({ $0.tag == .bugfix })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        text = text + "</ul></h1>"
        return text
    }
}

struct Feature: Identifiable, Equatable {
    let id: UUID
    var title: String
    let tag: FeatureTag
}

enum FeatureTag: String {
    case new
    case improvement
    case bugfix
}

enum previewMode: String, Identifiable, CaseIterable {
    case normal
    case html
    case screenshot
    
    var id: String { self.rawValue }
    
    var name: String {
        switch self {
        case .normal:
            "Normal"
        case .html:
            "HTML"
        case .screenshot:
            "Screenshot"
        }
    }
    
    @ViewBuilder
    func view(release: Release) -> some View {
        switch self {
        case .normal:
            NormalTextPreview(release: release)
        case .html:
            Text("HTML")
        case .screenshot:
            Text("Screenshot")
        }
    }
    
    func text(release: Release) -> String? {
        switch self {
        case .normal:
            normalTextFor(release: release)
        case .html:
            htmlTextFor(release: release)
        case .screenshot:
            nil
        }
    }
    
    
    func normalTextFor(release: Release) -> String {
        var text = ""
        
        if !release.features.filter({ $0.tag == .new }).isEmpty {
            text = "New: \n"
            
            let newFeatures = release.features.filter({ $0.tag == .new })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        if !release.features.filter({ $0.tag == .improvement }).isEmpty {
            text = text +  "\n\nImprovements: \n"
            
            let newFeatures = release.features.filter({ $0.tag == .improvement })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        
        if !release.features.filter({ $0.tag == .bugfix }).isEmpty {
            text = text + "\n\nBugfixes: \n"
            
            let newFeatures = release.features.filter({ $0.tag == .bugfix })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        return text
    }
    
    func htmlTextFor(release: Release) -> String {
        var text = "<h1><ul>"
        
        if !release.features.filter({ $0.tag == .new }).isEmpty {
            text = "New: \n"
            
            let newFeatures = release.features.filter({ $0.tag == .new })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        if !release.features.filter({ $0.tag == .improvement }).isEmpty {
            text = text +  "\n\nImprovements: \n"
            
            let newFeatures = release.features.filter({ $0.tag == .improvement })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        
        if !release.features.filter({ $0.tag == .bugfix }).isEmpty {
            text = text + "\n\nBugfixes: \n"
            
            let newFeatures = release.features.filter({ $0.tag == .bugfix })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        text = text + "</ul></h1>"
        return text
    }
}

struct NormalTextPreview: View {
    
    let release: Release
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


struct ContentView: View {
    
    @State var release: Release = Release(id: UUID(), features: [
        Feature(id: UUID(), title: "Added new feature", tag: .new),
        Feature(id: UUID(), title: "Feature now works", tag: .bugfix),
        
    ])
    
    @State var newFeature: String = ""
    @State var newImprovement: String = ""
    @State var newBugfix: String = ""
    
    @State var selectedPreviewMode: previewMode = .normal
    
    var body: some View {
        HStack(spacing: 0) {
            Form {
                Section {
                    ForEach($release.features) { $feature in
                        if feature.tag == .new {
                            TextField("Feature", text: $feature.title)
                                .labelsHidden()
                        }
                    }
                    
                    TextField("New Feature", text: $newFeature)
                        .onSubmit {
                            release.features.append(
                                Feature(
                                    id: UUID(),
                                    title: newFeature,
                                    tag: .new
                                )
                            )
                        }
                } header: {
                    Text("New")
                }
                
                Section {
                    ForEach($release.features) { $feature in
                        if feature.tag == .improvement {
                            TextField("Feature", text: $feature.title)
                                .labelsHidden()
                        }
                    }
                    TextField("Improvement", text: $newImprovement)
                        .onSubmit {
                            release.features.append(
                                Feature(
                                    id: UUID(),
                                    title: newImprovement,
                                    tag: .improvement
                                )
                            )
                        }
                    
                } header: {
                    Text("Improved")
                }
                
                Section {
                    ForEach($release.features) { $feature in
                        if feature.tag == .bugfix {
                            TextField("Feature", text: $feature.title)
                                .labelsHidden()
                        }
                    }
                    TextField("New Bugfix", text: $newBugfix)
                        .onSubmit {
                            release.features.append(
                                Feature(
                                    id: UUID(),
                                    title: newBugfix,
                                    tag: .bugfix
                                )
                            )
                        }
                } header: {
                    Text("Bugfixes")
                }
            }
            .formStyle(.grouped)
            
            VStack {
                Picker(selection: $selectedPreviewMode) {
                    ForEach(previewMode.allCases) { mode in
                        Text(mode.name).tag(mode)
                    }
                } label: {
                    Text("Preview Mode")
                }
                .pickerStyle(.segmented)
                .labelsHidden()

                Spacer()
                selectedPreviewMode.view(release: release)
                Spacer()
                
                HStack {
                    Spacer()
                    Button {
                        let pasteboard = NSPasteboard.general
                        pasteboard.clearContents()
                        pasteboard.setString(selectedPreviewMode.text(release: release), forType: .string)
                    } label: {
                        Text("Copy")
                    }

                }
            }
            .padding([.vertical, .trailing] , 12)
            .frame(width: 300)
        }
        .onChange(of: release.features) { oldValue, newValue in
            releaseNotesTextMaker()
        }
        .onAppear {
            releaseNotesTextMaker()
        }
    }
    
    @State var releaseNotesText = ""
    
    func releaseNotesTextMaker() {
        var text = ""
        
        if !release.features.filter({ $0.tag == .new }).isEmpty {
            text = "New: \n"
            
            let newFeatures = release.features.filter({ $0.tag == .new })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        if !release.features.filter({ $0.tag == .improvement }).isEmpty {
            text = text +  "\n\nImprovements: \n"
            
            let newFeatures = release.features.filter({ $0.tag == .improvement })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        
        if !release.features.filter({ $0.tag == .bugfix }).isEmpty {
            text = text + "\n\nBugfixes: \n"
            
            let newFeatures = release.features.filter({ $0.tag == .bugfix })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        releaseNotesText = text
    }
}

#Preview {
    ContentView()
}
