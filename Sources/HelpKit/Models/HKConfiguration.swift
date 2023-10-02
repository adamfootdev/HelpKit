//
//  HKConfiguration.swift
//  HelpKit
//
//  Created by Adam Foot on 28/09/2023.
//

import Foundation

public struct HKConfiguration {
    public let displayMode: HKDisplayMode
    public let topicSections: [HKTopicSection]
    public let getSupportAction: (() -> Void)?

    public init(
        displayMode: HKDisplayMode = .navigation,
        topicSections: [HKTopicSection],
        getSupportAction: (() -> Void)? = nil
    ) {
        self.displayMode = displayMode
        self.topicSections = topicSections
        self.getSupportAction = getSupportAction
    }

    static let example = HKConfiguration(
        displayMode: .navigation,
        topicSections: [.example],
        getSupportAction: {
            print("Get Support")
        }
    )
}
