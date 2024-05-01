//
//  HKDisplayMode.swift
//  HelpKit
//
//  Created by Adam Foot on 28/09/2023.
//

import Foundation

/// A custom enum used to indicate how HelpKit is displayed.
public enum HKDisplayMode: Sendable {

    /// Displays the topic below the title.
    case inline

    /// Uses a `NavigationLink` to display the topic. This requires the `HelpView` to be embedded in a `NavigationStack` or `NavigationSplitView` to push the views.
    case navigation
}
