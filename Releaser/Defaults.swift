//
//  Defaults.swift
//  Changelogger
//
//  Created by Jordi Bruin on 08/10/2024.
//

import Defaults

extension Defaults.Keys {
    static let apps = Key<[Application]>("apps", default: [])
    static let selectedPreviewMode = Key<PreviewMode>("selectedPreviewMode", default: .normal)
    
//    static let userFeatureTags = Key<[FeatureTag]>("userFeatureTags", default: [])
}
