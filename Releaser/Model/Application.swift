//
//  Application.swift
//  Changelogger
//
//  Created by Jordi Bruin on 08/10/2024.
//

import Defaults
import SwiftUI

struct Application: Identifiable, Codable, Defaults.Serializable, Hashable {
    var name: String
    var releases: [Release]
    let id: UUID
    var imageUrl: URL? = nil
    
    
    var lastRelease: Release? {
        releases.first
    }
}
