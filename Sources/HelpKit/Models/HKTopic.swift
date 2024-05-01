//
//  HKTopic.swift
//  HelpKit
//
//  Created by Adam Foot on 28/09/2023.
//

import SwiftUI

/// A custom struct containing details about a help topic.
public struct HKTopic: Identifiable, Sendable {

    /// The stable identity of the topic as a `UUID`.
    public let id = UUID()

    /// A `String` containing the title of the topic.
    public let title: String

    /// An `Optional<String>` containing the name of a system image to use
    /// as the icon in the topics list.
    public let iconSystemImage: String?

    /// The `Color` to use to tint the icon in the topics list.
    public let iconTint: Color

    /// A `String` containing details about the help topic.
    public let content: String

    /// An `Optional<Image>` to display above the content on the help topic screen.
    public let contentImage: Image?

    /// An optional array of `HKLink` that contains a list of links to display below the content
    /// on the help topic screen.
    public let links: [HKLink]?

    /// An optional array of `String` that contains additional keywords to use when filtering help
    /// topics that arenʼt used in the title or content.
    public let keywords: [String]?
    
    /// Initializes a new `HKTopic` struct which contains details about a help topic.
    /// - Parameters:
    ///   - title: A `String` containing the title of the topic.
    ///   - iconSystemImage: An `Optional<String>` containing the name of a system image to use
    ///   as the icon in the topics list. Defaults to `nil`.
    ///   - iconTint: The `Color` to use to tint the icon in the topics list. Defaults to `.accentColor`.
    ///   - content: A `String` containing details about the help topic.
    ///   - contentImage: An `Optional<Image>` to display above the content on the help topic screen.
    ///   Defaults to `nil`.
    ///   - links: An optional array of `HKLink` that contains a list of links to display below the content
    ///   on the help topic screen. Defaults to `nil`.
    ///   - keywords: An optional array of `String` that contains additional keywords to use when
    ///   filtering help topics that arenʼt used in the title or content. Defaults to `nil`.
    public init(
        _ title: String,
        iconSystemImage: String? = nil,
        iconTint: Color = .accentColor,
        content: String,
        contentImage: Image? = nil,
        links: [HKLink]? = nil,
        keywords: [String]? = nil
    ) {
        self.title = title
        self.iconSystemImage = iconSystemImage
        self.iconTint = iconTint
        self.content = content
        self.contentImage = contentImage
        self.links = links
        self.keywords = keywords
    }
    
    /// An example `HKTopic` to be used in SwiftUI previews.
    static let example = HKTopic(
        "Example Topic",
        iconSystemImage: "questionmark.circle",
        iconTint: .accentColor,
        content: "Some content goes here…",
        contentImage: nil,
        links: [.init("Website", url: URL(string: "https://adamfoot.dev")!)],
        keywords: ["example"]
    )
}

extension HKTopic: Comparable {
    public static func <(lhs: HKTopic, rhs: HKTopic) -> Bool {
        lhs.title < rhs.title
    }
}
