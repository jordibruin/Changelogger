//
//  Feature.swift
//  Changelogger
//
//  Created by Jordi Bruin on 02/10/2024.
//

import SwiftUI
import Defaults
//
struct Feature: Identifiable, Equatable, Codable, Defaults.Serializable, Hashable {
    let id: UUID
    var title: String
    let tag: FeatureTag
    var pro: Bool
}
