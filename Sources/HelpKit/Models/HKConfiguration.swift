//
//  HKConfiguration.swift
//  HelpKit
//
//  Created by Adam Foot on 28/09/2023.
//

import Foundation

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit
#elseif os(macOS)
import AppKit
#elseif os(watchOS)
import WatchKit
#endif

/// A custom struct containing details for HelpKit.
public struct HKConfiguration: Sendable {

    /// A custom enum used to indicate how HelpKit is displayed.
    /// Please note `.inline` is only available on iOS & macOS.
    public let displayMode: HKDisplayMode

    /// An array of `HKTopicSection` which contains all of the help topics grouped by section.
    public let topicSections: [HKTopicSection]

    /// An optional completion block to perform when the user selects the Get Support button.
    public let getSupportAction: (@Sendable () -> Void)?

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
        getSupportAction: (@Sendable () -> Void)? = nil
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

extension HKConfiguration {

    /// Initializes a new `HKConfiguration` struct which contains details about
    /// how HelpKit will be displayed and the topics to use.
    /// - Parameters:
    ///   - displayMode: A custom enum used to indicate how HelpKit is displayed.
    ///   Please note `.inline` is only available on iOS & macOS. Defaults to `.navigation`.
    ///   - topicSections: An array of `HKTopicSection` which contains all of the help
    ///   topics grouped by section.
    ///   - supportEmail: A `String` containing the email address to use for users to contact the app developer..
    public init(
        displayMode: HKDisplayMode = .navigation,
        topicSections: [HKTopicSection],
        supportEmail: String
    ) {
        self.displayMode = displayMode
        self.topicSections = topicSections

        let encodedEmail = supportEmail.addingPercentEncoding(
            withAllowedCharacters: .alphanumerics
        ) ?? supportEmail

        if let url = URL(string: "mailto:\(encodedEmail)?subject=Support") {
            #if os(iOS) || os(tvOS) || os(visionOS)
            self.getSupportAction = .init({
                MainActor.assumeIsolated {
                    UIApplication.shared.open(url)
                }
            })
            #elseif os(macOS)
            self.getSupportAction = .init({
                Task {
                    await MainActor.run {
                        NSWorkspace.shared.open(url)
                    }
                }
            })
            #elseif os(watchOS)
            self.getSupportAction = .init({
                MainActor.assumeIsolated {
                    WKExtension.shared().openSystemURL(url)
                }
            })
            #endif
        } else {
            self.getSupportAction = nil
        }
    }
}
