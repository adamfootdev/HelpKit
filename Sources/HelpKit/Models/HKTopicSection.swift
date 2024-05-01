//
//  HKTopicSection.swift
//  HelpKit
//
//  Created by Adam Foot on 28/09/2023.
//

import Foundation

/// A custom struct containing details about a help topic section.
public struct HKTopicSection: Identifiable, Sendable {
    
    /// The stable identity of the section as a `UUID`.
    public let id = UUID()
    
    /// A `String` containing the title of the section.
    public let title: String?
    
    /// An array of `HKTopic` which contains all of the help topics for the section.
    public let topics: [HKTopic]
    
    /// Initializes a new `HKTopicSection` struct which contains details about a help topic section.
    /// - Parameters:
    ///   - title: A `String` containing the title of the section.
    ///   - topics: An array of `HKTopic` which contains all of the help topics for the section.
    public init(_ title: String?, topics: [HKTopic]) {
        self.title = title
        self.topics = topics
    }

    /// An example `HKTopicSection` to be used in SwiftUI previews.
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
