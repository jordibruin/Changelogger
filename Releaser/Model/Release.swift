//
//  Release.swift
//  Changelogger
//
//  Created by Jordi Bruin on 02/10/2024.
//

import SwiftUI
import Defaults

struct Release: Identifiable, Codable, Defaults.Serializable, Hashable {
    let id: UUID
    var versionNumber: String
    var features: [Feature]
    var date: Date?
    
    var normalText: String {
        var text = ""
        
        if !features.filter({ $0.tag == .new }).isEmpty {
            text = "New: \n"
            
            let newFeatures = features.filter({ $0.tag == .new })
            for feature in newFeatures {
                text = text + "• \(feature.title)\(feature.pro ? " (Pro)" : "")\n"
            }
        }
        
        if !features.filter({ $0.tag == .improvement }).isEmpty {
            text = text +  "\nImprovements: \n"
            
            let newFeatures = features.filter({ $0.tag == .improvement })
            for feature in newFeatures {
                text = text + "• \(feature.title)\(feature.pro ? " (Pro)" : "")\n"
            }
        }
        
        
        if !features.filter({ $0.tag == .bugfix }).isEmpty {
            text = text + "\nBugfixes: \n"
            
            let newFeatures = features.filter({ $0.tag == .bugfix })
            for feature in newFeatures {
                text = text + "• \(feature.title)\(feature.pro ? " (Pro)" : "")\n"
            }
        }
        
        return text
    }
    
    var htmlText: String {
        var text = "<ul>\n"
        
        text = text + "<h2>\(self.versionNumber)</h2>\n"
        
        if !features.filter({ $0.tag == .new }).isEmpty {
            text = text + "<h3>New:</h3>\n"
            
            let newFeatures = features.filter({ $0.tag == .new })
            for feature in newFeatures {
                text = text + "<li>\(feature.title)\(feature.pro ? " (Pro)" : "")</li>\n"
            }
        }
        
        if !features.filter({ $0.tag == .improvement }).isEmpty {
            text = text +  "\n<h3>Improvements:</h3>\n"
            
            let newFeatures = features.filter({ $0.tag == .improvement })
            for feature in newFeatures {
                text = text + "<li>\(feature.title)\(feature.pro ? " (Pro)" : "")</li>\n"
            }
        }
        
        
        if !features.filter({ $0.tag == .bugfix }).isEmpty {
            text = text + "\n<h3>Bugfixes:</h3>\n"
            
            let newFeatures = features.filter({ $0.tag == .bugfix })
            for feature in newFeatures {
                text = text + "<li>\(feature.title)\(feature.pro ? " (Pro)" : "")</li>\n"
            }
        }
        
        text = text + "</ul>"
        return text
    }
    
    var jsonText: String {
        var featureList: [[String: Any]] = []
        
        let newFeatures = features.filter { $0.tag == .new }
        let improvements = features.filter { $0.tag == .improvement }
        let bugfixes = features.filter { $0.tag == .bugfix }
        
        // Append new features
        for feature in newFeatures {
            featureList.append([
                "title": feature.title,
                "type": "new",
                "requiresPro": feature.pro
            ])
        }
        
        // Append improvements
        for feature in improvements {
            featureList.append([
                "title": feature.title,
                "type": "improved",
                "requiresPro": feature.pro
            ])
        }
        
        // Append bugfixes
        for feature in bugfixes {
            featureList.append([
                "title": feature.title,
                "type": "fixed",
                "requiresPro": feature.pro
            ])
        }
        
        // Convert to JSON format
        let jsonObject: [String: Any] = [
            "version": self.versionNumber,
            "date": "2024-10-01",
            "features": featureList
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
            return String(data: jsonData, encoding: .utf8) ?? "{}"
        }
        
        return "{}"
    }
}


