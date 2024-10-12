//
//  ReleaseDetailView.swift
//  Changelogger
//
//  Created by Jordi Bruin on 08/10/2024.
//

import SwiftUI
import Defaults

struct ReleaseDetailView: View {
    
    @Binding var release: Release
    @Default(.selectedPreviewMode) var selectedPreviewMode
    
    @State var newFeature: String = ""
    @State var newImprovement: String = ""
    @State var newBugfix: String = ""
    
    var body: some View {
        HStack(spacing: 0) {
            verticalInput
            preview
        }
        .navigationTitle("Changelogger")
    }
    
    var verticalInput: some View {
        Form {
            newSection
            improvedSection
            bugfixSection
        }
        .formStyle(.grouped)
    }
    
    var newSection: some View {
        Section {
            TextField("New Feature", text: $newFeature, prompt: Text("New Feature"))
                .onSubmit {
                    release.features.append(
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
            
            ForEach($release.features, editActions: .all) { $feature in
//                ForEach($release.features) { $feature in
                if feature.tag == .new {
                    HStack {

                        TextField("Feature", text: $feature.title, axis: .vertical)
                            .labelsHidden()
                            .onSubmit {
                                if feature.title.isEmpty {
                                    if let index = release.features.firstIndex(of: feature) {
                                        release.features.remove(at: index)
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
                        
                        Button {
                            if let index = release.features.firstIndex(of: feature) {
                                release.features.remove(at: index)
                            }
                        } label: {
                            Image(systemName: "trash.fill")
                                .foregroundStyle(.red)
                        }
                        .buttonStyle(.plain)
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
                    release.features.append(
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
            
            ForEach($release.features) { $feature in
                if feature.tag == .improvement {
                    HStack {
                        TextField("Feature", text: $feature.title, axis: .vertical)
                            .labelsHidden()
                            .onSubmit {
                                if feature.title.isEmpty {
                                    if let index = release.features.firstIndex(of: feature) {
                                        release.features.remove(at: index)
                                    }
                                }
                            }

                        Spacer()

                        Button {
                            if let index = release.features.firstIndex(of: feature) {
                                release.features.remove(at: index)
                            }
                        } label: {
                            Image(systemName: "trash.fill")
                                .foregroundStyle(.red)
                        }
                        .buttonStyle(.plain)
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
                    release.features.append(
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
            
            ForEach($release.features) { $feature in
                if feature.tag == .bugfix {
                    HStack {
                        TextField("Feature", text: $feature.title, axis: .vertical)
                            .labelsHidden()
                            .onSubmit {
                                if feature.title.isEmpty {
                                    if let index = release.features.firstIndex(of: feature) {
                                        release.features.remove(at: index)
                                    }
                                }
                            }

                        Spacer()
                        Button {
                            if let index = release.features.firstIndex(of: feature) {
                                release.features.remove(at: index)
                            }
                        } label: {
                            Image(systemName: "trash.fill")
                                .foregroundStyle(.red)
                        }
                        .buttonStyle(.plain)
                        .padding(.trailing, 4)
                    }
                }
            }
        } header: {
            Text("Bugfixes")
        }
    }
    

    
    var input: some View {
        Form {
            Section {
                ForEach($release.features, editActions: .all) { $feature in
//                ForEach($release.features) { $feature in
                    if feature.tag == .new {
                        HStack {

                            TextField("Feature", text: $feature.title, axis: .vertical)
                                .labelsHidden()
                                .onSubmit {
                                    if feature.title.isEmpty {
                                        if let index = release.features.firstIndex(of: feature) {
                                            release.features.remove(at: index)
                                        }
                                    }
                                }

                            Spacer()

                            Button {
                                if let index = release.features.firstIndex(of: feature) {
                                    release.features.remove(at: index)
                                }
                            } label: {
                                Image(systemName: "trash.fill")
                                    .foregroundStyle(.red)
                            }
                            .buttonStyle(.plain)
                            .padding(.trailing, 4)


                        }
                    }
                }

            } header: {
                Text("New")
            }

            Section {
                TextField("New Feature", text: $newFeature)
                    .onSubmit {
                        release.features.append(
                            Feature(
                                id: UUID(),
                                title: newFeature,
                                tag: .new,
                                pro: false
                            )
                        )
                        newFeature = ""
                    }
            }

            Section {
                ForEach($release.features) { $feature in
                    if feature.tag == .improvement {
                        HStack {

                            TextField("Feature", text: $feature.title, axis: .vertical)
                                .labelsHidden()
                                .onSubmit {
                                    if feature.title.isEmpty {
                                        if let index = release.features.firstIndex(of: feature) {
                                            release.features.remove(at: index)
                                        }
                                    }
                                }

                            Spacer()

                            Button {
                                if let index = release.features.firstIndex(of: feature) {
                                    release.features.remove(at: index)
                                }
                            } label: {
                                Image(systemName: "trash.fill")
                                    .foregroundStyle(.red)
                            }
                            .buttonStyle(.plain)
                            .padding(.trailing, 4)


                        }
                    }
                }


            } header: {
                Text("Improved")
            }

            Section {
                TextField("Improvement", text: $newImprovement)
                    .onSubmit {
                        release.features.append(
                            Feature(
                                id: UUID(),
                                title: newImprovement,
                                tag: .improvement,
                                pro: false
                            )
                        )
                        newImprovement = ""
                    }
            }

            Section {
                ForEach($release.features) { $feature in
                    if feature.tag == .bugfix {
                        HStack {
                            TextField("Feature", text: $feature.title, axis: .vertical)
                                .labelsHidden()
                                .onSubmit {
                                    if feature.title.isEmpty {
                                        if let index = release.features.firstIndex(of: feature) {
                                            release.features.remove(at: index)
                                        }
                                    }
                                }

                            Spacer()
                            Button {
                                if let index = release.features.firstIndex(of: feature) {
                                    release.features.remove(at: index)
                                }
                            } label: {
                                Image(systemName: "trash.fill")
                                    .foregroundStyle(.red)
                            }
                            .buttonStyle(.plain)
                            .padding(.trailing, 4)
                        }
                    }
                }
            } header: {
                Text("Bugfixes")
            }

            Section {
                TextField("New Bugfix", text: $newBugfix)
                    .onSubmit {
                        release.features.append(
                            Feature(
                                id: UUID(),
                                title: newBugfix,
                                tag: .bugfix,
                                pro: false
                            )
                        )

                        newBugfix = ""
                    }
            }
        }
        .formStyle(.grouped)
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
                .pickerStyle(.segmented)
                .labelsHidden()
                .padding()
//                .frame(width: 300)
                
                Spacer()
                selectedPreviewMode.view(release: release)
                Spacer()

                HStack {
                    Spacer()

                    if let textToCopy {
                        Button {
                            let pasteboard = NSPasteboard.general
                            pasteboard.clearContents()
                            pasteboard.setString(textToCopy, forType: .string)
                        } label: {
                            Text("Copy Text")
                        }
                    }

                    if let imageToCopy {
                        Button {
                            let pasteboard = NSPasteboard.general
                            pasteboard.clearContents()
                            pasteboard.setString(imageToCopy, forType: .string)
                        } label: {
                            Text("Copy Image")
                        }

                    }
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
            release.normalText
        case .html:
            release.htmlText
        case .json:
            release.jsonText
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
