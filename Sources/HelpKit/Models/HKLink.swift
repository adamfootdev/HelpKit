//
//  HKLink.swift
//  HelpKit
//
//  Created by Adam Foot on 28/09/2023.
//

import Foundation

/// A custom struct used to contain details about a help link.
public struct HKLink: Identifiable {
    
    /// The stable identity of the link as a `UUID`.
    public let id = UUID()
    
    /// A `String` containing the title of the link.
    public let title: String

    /// The `URL` for the link.
    public let url: URL
    
    /// Initializes a new `HKLink` struct which contains details about a help link.
    /// - Parameters:
    ///   - title: An `Optional<String>` containing the title of the link.
    ///   If a title is not supplied, the URL will be displayed instead.
    ///   - url: The `URL` for the link.
    public init(_ title: String?, url: URL) {
        self.title = title ?? url.absoluteString
        self.url = url
    }
}

extension HKLink: Comparable {
    public static func <(lhs: HKLink, rhs: HKLink) -> Bool {
        lhs.title < rhs.title
    }
}
