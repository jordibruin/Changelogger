struct ReleaseDetailView: View {
    
    @Binding var release: Release
    @State var selectedPreviewMode: PreviewMode = .html
    
    @State var newFeature: String = ""
    @State var newImprovement: String = ""
    @State var newBugfix: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            preview
            input
        }
        .navigationTitle("Changelogger")
        .toolbar {
            ToolbarItem {
                Picker(selection: $selectedPreviewMode) {
                    ForEach(PreviewMode.allCases) { mode in
                        Text(mode.name).tag(mode)
                    }
                } label: {
                    Text("Preview Mode")
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                .frame(width: 200)
            }
            
            ToolbarItem(placement: .automatic, content: {
                Button {
                    release.features.removeAll()
                } label: {
                    Text("Clear")
                }
            })
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
                                tag: .new
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
                                tag: .improvement
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
                                tag: .bugfix
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
        case .screenshot:
            nil
        }
    }

    var imageToCopy: String? {
        switch selectedPreviewMode {
        case .normal, .html:
            nil
        case .screenshot:
            "Image goes here"
        }
    }
}
