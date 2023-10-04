//
//  HKConfiguration.swift
//  HelpKit
//
//  Created by Adam Foot on 28/09/2023.
//

import Foundation

/// A custom struct containing details for HelpKit.
public struct HKConfiguration {

    /// A custom enum used to indicate how HelpKit is displayed.
    /// Please note `.inline` is only available on iOS & macOS.
    public let displayMode: HKDisplayMode

    /// An array of `HKTopicSection` which contains all of the help topics grouped by section.
    public let topicSections: [HKTopicSection]

    /// An optional completion block to perform when the user selects the Get Support button.
    public let getSupportAction: (() -> Void)?
    
    /// Initializes a new `HKConfiguration` struct which contains details about
    /// how HelpKit will be displayed and the topics to use.
    /// - Parameters:
    ///   - displayMode: A custom enum used to indicate how HelpKit is displayed.
    ///   Please note `.inline` is only available on iOS & macOS. Defaults to `.navigation`.
    ///   - topicSections: An array of `HKTopicSection` which contains all of the help 
    ///   topics grouped by section.
    ///   - getSupportAction: An optional completion block to perform when the user selects
    ///   the Get Support button. Defaults to `nil`.
    public init(
        displayMode: HKDisplayMode = .navigation,
        topicSections: [HKTopicSection],
        getSupportAction: (() -> Void)? = nil
    ) {
        self.displayMode = displayMode
        self.topicSections = topicSections
        self.getSupportAction = getSupportAction
    }

    /// An example `HKConfiguration` to be used in SwiftUI previews.
    static let example = HKConfiguration(
        displayMode: .navigation,
        topicSections: [.example]
    ) {
        print("Get Support")
    }
}
