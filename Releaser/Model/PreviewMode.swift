//
//  previewMode.swift
//  Changelogger
//
//  Created by Jordi Bruin on 02/10/2024.
//

import SwiftUI
import Defaults

enum PreviewMode: String, Identifiable, CaseIterable, Defaults.Serializable {
    case normal
    case html
    case json
    case screenshot
    
    var id: String { self.rawValue }
    
    var name: String {
        switch self {
        case .normal:
            "Normal"
        case .html:
            "HTML"
        case .json:
            "JSON"
        case .screenshot:
            "Screenshot"
        }
    }
    
    @ViewBuilder
    func view(release: Release, app: Application) -> some View {
        switch self {
        case .normal:
            TextEditor(text: .constant(release.normalText))
                .font(.title2)
                .padding()
        case .html:
            TextEditor(text: .constant(release.htmlText))
                .font(.title2)
                .padding()
        case .json:
            TextEditor(text: .constant(release.jsonText))
                .font(.title2)
                .padding()
        case .screenshot:
            ScreenshotView(release: release, app: app)
        }
    }
    
////    func text(release: Release) -> String? {
////        switch self {
////        case .normal:
////            normalTextFor(release: release)
////        case .html:
////            htmlTextFor(release: release)
////        case .screenshot:
////            nil
////        }
////    }
//    
//    
//    func normalTextFor(release: Release) -> String {
//        var text = ""
//        
//        if !release.features.filter({ $0.tag == .new }).isEmpty {
//            text = "New: \n"
//            
//            let newFeatures = release.features.filter({ $0.tag == .new })
//            for feature in newFeatures {
//                text = text + "- \(feature.title)\n"
//            }
//        }
//        
//        if !release.features.filter({ $0.tag == .improvement }).isEmpty {
//            text = text +  "\n\nImprovements: \n"
//            
//            let newFeatures = release.features.filter({ $0.tag == .improvement })
//            for feature in newFeatures {
//                text = text + "- \(feature.title)\n"
//            }
//        }
//        
//        
//        if !release.features.filter({ $0.tag == .bugfix }).isEmpty {
//            text = text + "\n\nBugfixes: \n"
//            
//            let newFeatures = release.features.filter({ $0.tag == .bugfix })
//            for feature in newFeatures {
//                text = text + "- \(feature.title)\n"
//            }
//        }
//        
//        return text
//    }
//    
//    func htmlTextFor(release: Release) -> String {
//        var text = "<h1><ul>"
//        
//        if !release.features.filter({ $0.tag == .new }).isEmpty {
//            text = "New: \n"
//            
//            let newFeatures = release.features.filter({ $0.tag == .new })
//            for feature in newFeatures {
//                text = text + "- \(feature.title)\n"
//            }
//        }
//        
//        if !release.features.filter({ $0.tag == .improvement }).isEmpty {
//            text = text +  "\n\nImprovements: \n"
//            
//            let newFeatures = release.features.filter({ $0.tag == .improvement })
//            for feature in newFeatures {
//                text = text + "- \(feature.title)\n"
//            }
//        }
//        
//        
//        if !release.features.filter({ $0.tag == .bugfix }).isEmpty {
//            text = text + "\n\nBugfixes: \n"
//            
//            let newFeatures = release.features.filter({ $0.tag == .bugfix })
//            for feature in newFeatures {
//                text = text + "- \(feature.title)\n"
//            }
//        }
//        
//        text = text + "</ul></h1>"
//        return text
//    }
}
