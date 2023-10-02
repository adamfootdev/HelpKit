//
//  HKTopicSection.swift
//  HelpKit
//
//  Created by Adam Foot on 28/09/2023.
//

import Foundation

public struct HKTopicSection: Identifiable {
    public let id = UUID()
    public let title: String?
    public let topics: [HKTopic]

    public init(_ title: String?, topics: [HKTopic]) {
        self.title = title
        self.topics = topics
    }

    static let example = HKTopicSection(
        "Section",
        topics: [.example]
    )
}

extension HKTopicSection: Comparable {
    public static func <(lhs: HKTopicSection, rhs: HKTopicSection) -> Bool {
        (lhs.title ?? "") < (rhs.title ?? "")
    }
}
