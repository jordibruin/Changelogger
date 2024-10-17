//
//  ReleaserApp.swift
//  Releaser
//
//  Created by Jordi Bruin on 29/09/2024.
//

import SwiftUI
import Sparkle
import TelemetryClient

@main
struct ChangeloggerApp: App {
    
    private let updaterController: SPUStandardUpdaterController

    init() {
        
        let config = TelemetryDeck.Config(appID: "17D2E27D-8E20-414D-8485-0FC9A0E80DF5")
        TelemetryDeck.initialize(config: config)
            
        updaterController = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            CommandGroup(after: .systemServices) {
                CheckForUpdatesView(updater: updaterController.updater)
            }
        }
        
        Settings {
            NavigationSplitView {
                List {
                    ForEach(1...10, id: \.self) { index in
                        NavigationLink {
                            Text("index \(index)")
                                .toolbar {
                                    Text("TESt")
                                }
                        } label: {
                            Text("index \(index)")
                        }
                    }
                }
                .toolbar(removing: .sidebarToggle)
            } detail: {
                Color.blue
            }
            .frame(width: 600, height: 400)
        }
        .windowStyle(.automatic)
        .windowToolbarStyle(.unified)
        .windowResizability(.contentSize)
        
    }
}

import Defaults

struct SettingsView: View {
    
//    @Default(.userFeatureTags) var userFeatureTags
    
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink {
                    generalSettings
                } label: {
                    Text("General")
                }

            }
            .listStyle(.sidebar)
        } detail: {
            Text("Select a setting")
        }
    }
    
    var generalSettings: some View {
        Form {
            Section {
                
//                ForEach(userFeatureTags) { tag in
//                    Text(tag)
//                }
            }
        }
        .formStyle(.grouped)
    }
}
