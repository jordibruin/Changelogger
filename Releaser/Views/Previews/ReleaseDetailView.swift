//
//  ReleaseDetailView.swift
//  Changelogger
//
//  Created by Jordi Bruin on 08/10/2024.
//

import SwiftUI
import Defaults
import UniformTypeIdentifiers

struct ReleaseDetailView: View {
    
    @Binding var app: Application
    @State var activeRelease: Release = Release(id: UUID(), versionNumber: "", features: [])
    
    @Default(.selectedPreviewMode) var selectedPreviewMode
    
    @State var newFeature: String = ""
    @State var newImprovement: String = ""
    @State var newBugfix: String = ""
    
    var body: some View {
        HStack(spacing: 0) {
            verticalInput
            preview
        }
        .onChange(of: activeRelease, perform: { newValue in
            print("Active release changed, save that shit")
            if let lastRelease = app.lastRelease {
                print(lastRelease.id)
            }
                    
            if let index = app.releases.firstIndex(where: { $0.id == activeRelease.id } ) {
                app.releases[index] = activeRelease
            }
        })
        .toolbar {
            if let latestRelease, activeRelease.versionNumber != latestRelease.versionNumber {
                ToolbarItem(placement: .navigation) {
                    SmallButton(action: {
                        activeRelease = latestRelease
                    }, title: "", icon: "arrow.turn.left.up", helpText: "Change to latest version", tintColor: .secondary)
                }
            }

//            ToolbarItem {
//                Menu {
//                    ForEach(app.releases.prefix(5)) { release in
//                        Button {
//                            self.activeRelease = release
//                        } label: {
//                            Text(release.versionNumber)
//                        }
//                    }
//                    
//                    Divider()
//                    Menu {
//                        ForEach(app.releases.dropFirst(5)) { release in
//                            Button {
//                                self.activeRelease = release
//                            } label: {
//                                Text(release.versionNumber)
//                            }
//                        }
//                    } label: {
//                        Text("Older versions")
//                    }
//
//                } label: {
//                    Text(activeRelease.versionNumber)
//                }
//            }
//            
            ToolbarItem {
                SmallButton(action: {
                    var newVersionNumber = ""
                    
                    if let latestRelease = app.releases.first {
//                        newVersionNumber = latestRelease.versionNumber
                        
                        let versionComponents = latestRelease.versionNumber.split(separator: ".").map { Int($0) ?? 0 }
                        
                        if versionComponents.count == 2 {
                            let major = versionComponents[0]
                            var minor = versionComponents[1]
                            
                            minor += 1
                            
                            // Logic for incrementing minor/major versions can be added here if needed
                            newVersionNumber = "\(major).\(minor)"
                        } else if versionComponents.count == 3 {
                            let major = versionComponents[0]
                            let minor = versionComponents[1]
                            var patch = versionComponents[2]
                            
                            patch += 1
                            
                            // Logic for incrementing minor/major versions can be added here if needed
                            newVersionNumber = "\(major).\(minor).\(patch)"
                        }
                    }
                    
                    let newRelease = Release(id: UUID(), versionNumber: newVersionNumber, features: [])
                    app.releases.insert(newRelease, at: 0)
                    activeRelease = newRelease
                    Analytics.send(.newVersion)
                }, title: "New Release", icon: "plus", helpText: "Add a new version", tintColor: .blue, symbolColor: .blue)
            }
        }
        .navigationTitle(Text(""))
        .toolbar(content: {
            ToolbarItem(placement: .navigation) {
                Menu {
                    ForEach(app.releases.prefix(5)) { release in
                        Button {
                            self.activeRelease = release
                        } label: {
                            Text(release.versionNumber)
                        }
                    }
                    
                    Divider()
                    Menu {
                        ForEach(app.releases.dropFirst(5)) { release in
                            Button {
                                self.activeRelease = release
                            } label: {
                                Text(release.versionNumber)
                            }
                        }
                    } label: {
                        Text("Older versions")
                    }

                } label: {
                    HStack {
                        Group {
                            if let imageUrl = app.imageUrl, let savedImage = NSImage(contentsOf: imageUrl) {
                                Image(nsImage: savedImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            } else {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .foregroundStyle(.secondary.opacity(0.5))
                                    .frame(width: 32, height: 32)
                            }
                        }
                        .onDrop(of: [UTType.image], isTargeted: nil) { providers in
                            if let provider = providers.first {
                                provider.loadDataRepresentation(forTypeIdentifier: UTType.image.identifier) { data, _ in
                                    if let data = data, let nsImage = NSImage(data: data) {
                                        saveImageLocally(image: nsImage)
                                    }
                                }
                            }
                            return true
                        }
                        
                        Text("\(app.name) \(activeRelease.versionNumber)")
                            .font(.title3)
                            .bold()
                        
                        Image(systemName: "chevron.down")
                    }
                    .contentShape(Rectangle())
                }
                .menuStyle(.button)
                .buttonStyle(.plain)
            }
        })
        .onAppear {
            // TODO: Will this break when there's no releases? Does it actually get added?
            if let newestRelease = app.releases.first {
                activeRelease = newestRelease
            } else {
                // add release to app
                let firstRelease = Release(id: UUID(), versionNumber: "1.0", features: [])
                app.releases.append(firstRelease)
                activeRelease = firstRelease
            }
            
                
        }
    }
    
    // Function to save the image in the Application Support directory
        func saveImageLocally(image: NSImage) {
            guard let imageData = image.tiffRepresentation,
                  let bitmapRep = NSBitmapImageRep(data: imageData),
                  let pngData = bitmapRep.representation(using: .png, properties: [:]) else {
                return
            }
            
            // Get the Application Support directory path
            if let appSupportDir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
                let fileName = "\(app.name)_\(UUID().uuidString).png"
                let fileURL = appSupportDir.appendingPathComponent(fileName)
                
                do {
                    // Create the Application Support directory if it doesn't exist
                    try FileManager.default.createDirectory(at: appSupportDir, withIntermediateDirectories: true, attributes: nil)
                    
                    // Write the image data to the file
                    try pngData.write(to: fileURL)
                    
                    // Store the file URL in the application model
                    DispatchQueue.main.async {
                        app.imageUrl = fileURL
                    }
                } catch {
                    print("Error saving image: \(error.localizedDescription)")
                }
            }
        }
    
    var latestRelease: Release? {
        app.releases
            .sorted { ($0.date ?? Date.distantPast) > ($1.date ?? Date.distantPast) }
            .first
    }
    
    var verticalInput: some View {
        Form {
            versionNumberSection
            newSection
            improvedSection
            bugfixSection
            
            deleteSection
        }
        .formStyle(.grouped)
    }
    
    
    
    var versionNumberSection: some View {
        Section {
            TextField("Version Number", text: $activeRelease.versionNumber, prompt: Text("\(app.name) \(activeRelease.versionNumber)"))
//                .onSubmit {
//                    
//                }
                .labelsHidden()
        }
    }
    
    var newSection: some View {
        Section {
            TextField("New Feature", text: $newFeature, prompt: Text("New Feature"))
                .onSubmit {
                    activeRelease.features.append(
                        Feature(
                            id: UUID(),
                            title: newFeature,
                            tag: .new,
                            pro: false
                        )
                    )
                    newFeature = ""
                }
                .labelsHidden()
            
            ForEach($activeRelease.features, editActions: .all) { $feature in
//                ForEach($release.features) { $feature in
                if feature.tag == .new {
                    HStack {

                        TextField("Feature", text: $feature.title, axis: .vertical)
                            .labelsHidden()
                            .onSubmit {
                                if feature.title.isEmpty {
                                    if let index = activeRelease.features.firstIndex(of: feature) {
                                        activeRelease.features.remove(at: index)
                                    }
                                }
                            }

                        Spacer()

                        Button {
                            feature.pro.toggle()
                        } label: {
                            Text("PRO")
                                .font(.system(.subheadline, design: .rounded).weight(.semibold))
                                .foregroundColor(feature.pro ? .white : .secondary)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 4)
                                .background(feature.pro ? .blue : .secondary.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                                
                        }
                        .buttonStyle(.plain)
                        .padding(.trailing, 4)
                        
                        SmallButton(action: {
                            if let index = activeRelease.features.firstIndex(of: feature) {
                                activeRelease.features.remove(at: index)
                            }
                        }, title: "", icon: "trash.fill", helpText: "Delete this feature", tintColor: .red, symbolColor: .red)
                        .padding(.trailing, 4)


                    }
                }
            }

        } header: {
            Text("New")
        }
    }
    
    var improvedSection: some View {
        Section {
            TextField("Improvement", text: $newImprovement, prompt: Text("New Improvement"))
                .onSubmit {
                    activeRelease.features.append(
                        Feature(
                            id: UUID(),
                            title: newImprovement,
                            tag: .improvement,
                            pro: false
                        )
                    )
                    newImprovement = ""
                }
                .labelsHidden()
            
            ForEach($activeRelease.features) { $feature in
                if feature.tag == .improvement {
                    HStack {
                        TextField("Feature", text: $feature.title, axis: .vertical)
                            .labelsHidden()
                            .onSubmit {
                                if feature.title.isEmpty {
                                    if let index = activeRelease.features.firstIndex(of: feature) {
                                        activeRelease.features.remove(at: index)
                                    }
                                }
                            }

                        Spacer()

                        SmallButton(action: {
                            if let index = activeRelease.features.firstIndex(of: feature) {
                                activeRelease.features.remove(at: index)
                            }
                        }, title: "", icon: "trash.fill", helpText: "Delete this feature", tintColor: .red, symbolColor: .red)
                        
                        .padding(.trailing, 4)


                    }
                }
            }


        } header: {
            Text("Improved")
        }
    }
    
    var bugfixSection: some View {
        Section {
            TextField("New Bugfix", text: $newBugfix, prompt: Text("New Bugfix"))
                .onSubmit {
                    activeRelease.features.append(
                        Feature(
                            id: UUID(),
                            title: newBugfix,
                            tag: .bugfix,
                            pro: false
                        )
                    )

                    newBugfix = ""
                }
                .labelsHidden()
            
            ForEach($activeRelease.features) { $feature in
                if feature.tag == .bugfix {
                    HStack {
                        TextField("Feature", text: $feature.title, axis: .vertical)
                            .labelsHidden()
                            .onSubmit {
                                if feature.title.isEmpty {
                                    if let index = activeRelease.features.firstIndex(of: feature) {
                                        activeRelease.features.remove(at: index)
                                    }
                                }
                            }

                        Spacer()
                        
                        SmallButton(action: {
                            if let index = activeRelease.features.firstIndex(of: feature) {
                                activeRelease.features.remove(at: index)
                            }
                        }, title: "", icon: "trash.fill", helpText: "Delete this feature", tintColor: .red, symbolColor: .red)
                        .padding(.trailing, 4)
                    }
                }
            }
        } header: {
            Text("Bugfixes")
        }
    }
    

    @State var showConfirmDelete = false
    
    var deleteSection: some View {
        Section {
            Button {
                showConfirmDelete = true
            } label: {
                Text("Delete release")
            }
    
            .confirmationDialog("Delete \(activeRelease.versionNumber)", isPresented: $showConfirmDelete, actions: {
                Button {
                    if let index = app.releases.firstIndex(of: activeRelease) {
                        app.releases.remove(at: index)
                        if let latestRelease {
                            activeRelease = latestRelease
                        }
                    }
                } label: {
                    Text("Delete release")
                }
            }, message: {
                Text("Are you sure you want to delete this release? This can not be undone.")
            })
        }
    }
    
    var preview: some View {
        ZStack {
            Color(.controlBackgroundColor)

            VStack {
                Picker(selection: $selectedPreviewMode) {
                    ForEach(PreviewMode.allCases) { mode in
                        Text(mode.name).tag(mode)
                    }
                } label: {
                    Text("Preview Mode")
                }
                .onChange(of: selectedPreviewMode, { oldValue, newValue in
                    Analytics.send(.displayMode, with: ["mode": newValue.name])
                })
                .pickerStyle(.segmented)
                .labelsHidden()
                .padding()
//                .frame(width: 300)
                
                Spacer()
                selectedPreviewMode.view(release: activeRelease, app: app)
                Spacer()

                HStack {
                    Spacer()

                    if let textToCopy {
                        SmallButton(action: {
                            let pasteboard = NSPasteboard.general
                            pasteboard.clearContents()
                            pasteboard.setString(textToCopy, forType: .string)
                            Analytics.send(.copyText)
                        }, title: "Copy Text", helpText: "Copy the changelog text to the clipboard", tintColor: .blue)
                    }

//                    if let imageToCopy {
//                        SmallButton(action: {
//                            
//                            
//                            Analytics.send(.copyImage)
//                        }, title: "Copy Image", helpText: "Copy the changelog image to the clipboard", tintColor: .blue)
//                    }
                }
                .padding()
            }
            //        .padding([.vertical, .trailing] , 12)
        }
//        .frame(minWidth: 150, idealWidth: 400, maxWidth: 600)
    }

    var textToCopy: String? {
        switch selectedPreviewMode {
        case .normal:
            activeRelease.normalText
        case .html:
            activeRelease.htmlText
        case .json:
            activeRelease.jsonText
        case .screenshot:
            nil
        }
    }

    var imageToCopy: String? {
        switch selectedPreviewMode {
        case .normal, .html, .json:
            nil
        case .screenshot:
            "Image goes here"
        }
    }
}

#Preview(body: {
    NavigationStack {
        ReleaseDetailView(app: .constant(Application(name: "MacWhisper", releases: [
            Release(id: UUID(), versionNumber: "10.0", features: [
                Feature(id: UUID(), title: "Title", tag: .new, pro: false)
            ])
        ], id: UUID())))
       
    }
})
