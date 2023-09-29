//
//  HKTopic.swift
//  HelpKit
//
//  Created by Adam Foot on 28/09/2023.
//

import SwiftUI

public struct HKTopic: Identifiable {
    public let id = UUID()
    public let title: String
    public let iconSystemImage: String?
    public let iconTint: Color
    public let content: String
    public let contentImage: Image?
    public let links: [HKLink]?
    public let keywords: [String]?

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
    
    static let example= HKTopic(
        "Example Topic",
        iconSystemImage: "questionmark.circle",
        iconTint: .accentColor,
        content: "Some content goes here…",
        contentImage: nil,
        links: [.init("Website", url: URL(string: "https://adamfoot.dev")!)],
        keywords: ["example"]
    )
}
