//
//  HKLink.swift
//  HelpKit
//
//  Created by Adam Foot on 28/09/2023.
//

import Foundation

public struct HKLink: Identifiable {
    public let id = UUID()
    public let title: String
    public let url: URL

    public init(_ title: String, url: URL) {
        self.title = title
        self.url = url
    }
}
