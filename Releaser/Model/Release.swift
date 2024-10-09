struct Release: Identifiable {
    let id: UUID
    var features: [Feature]
    
    var normalText: String {
        var text = ""
        
        if !features.filter({ $0.tag == .new }).isEmpty {
            text = "New: \n"
            
            let newFeatures = features.filter({ $0.tag == .new })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        if !features.filter({ $0.tag == .improvement }).isEmpty {
            text = text +  "\n\nImprovements: \n"
            
            let newFeatures = features.filter({ $0.tag == .improvement })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        
        if !features.filter({ $0.tag == .bugfix }).isEmpty {
            text = text + "\n\nBugfixes: \n"
            
            let newFeatures = features.filter({ $0.tag == .bugfix })
            for feature in newFeatures {
                text = text + "- \(feature.title)\n"
            }
        }
        
        return text
    }
    
    var htmlText: String {
        var text = "<h1>\n"
        
        if !features.filter({ $0.tag == .new }).isEmpty {
            text = text + "<ul>New:</ul>\n"
            
            let newFeatures = features.filter({ $0.tag == .new })
            for feature in newFeatures {
                text = text + "<li>\(feature.title)</li>\n"
            }
        }
        
        if !features.filter({ $0.tag == .improvement }).isEmpty {
            text = text +  "\n\n<ul>Improvements:</ul>\n"
            
            let newFeatures = features.filter({ $0.tag == .improvement })
            for feature in newFeatures {
                text = text + "<li>\(feature.title)</li>\n"
            }
        }
        
        
        if !features.filter({ $0.tag == .bugfix }).isEmpty {
            text = text + "\n\n<ul>Bugfixes:</ul>\n"
            
            let newFeatures = features.filter({ $0.tag == .bugfix })
            for feature in newFeatures {
                text = text + "<li>\(feature.title)</li>\n"
            }
        }
        
        text = text + "</h1>"
        return text
    }
}