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

    public init(
        displayMode: HKDisplayMode = .navigation,
        topicSections: [HKTopicSection]
    ) {
        self.displayMode = displayMode
        self.topicSections = topicSections
    }

    static let example: HKConfiguration = {
        HKConfiguration(
            displayMode: .navigation,
            topicSections: [.example]
        )
    }()
}
