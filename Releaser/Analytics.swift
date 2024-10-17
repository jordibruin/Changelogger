import Foundation
import TelemetryClient

public struct Analytics {
    public static func send(_ option: AnalyticType, with additionalParameters: [String: String]? = nil, functionName: String = #function) {
        if let additionalParameters {
            TelemetryManager.send(option.rawValue, with: additionalParameters)
        } else {
            TelemetryManager.send(option.rawValue)
        }
    }
    
}

//
//  File.swift
//
//
//  Created by Ian Dundas on 24/06/2024.
//

import Foundation

public enum AnalyticType: String, Hashable {
    
    case newApp
    case newVersion
    
    case copyText
    case copyImage
    
    case displayMode
}

